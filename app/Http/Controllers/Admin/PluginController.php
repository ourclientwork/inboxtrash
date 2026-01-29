<?php

namespace App\Http\Controllers\Admin;

use File;
use Exception;
use ZipArchive;
use App\Models\Plugin;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Services\ImageService;
use App\Services\InstallService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;



class PluginController extends Controller
{

    protected $installService;

    public function __construct(InstallService $installService)
    {
        $this->installService = $installService;
    }


    public function index()
    {
        $get_plugins = $this->get_plugins();
        $plugins = Plugin::orderBy('is_featured', 'DESC')
            ->orderBy('status', 'DESC') // Change 'ASC' to 'DESC' if needed
            ->get();
        return view('admin.plugins.index')->with("plugins", $plugins)
            ->with("get_plugins", $get_plugins);
    }

    public function create()
    {
        return view('admin.plugins.create');
    }



    /**
     * The function installs or uninstalls a plugin and displays a success message using the Toastr
     * library.
     *
     * @param Plugin plugin The parameter `` is an instance of the `Plugin` class.
     *
     * @return the result of the `back()` function.
     */
    public function uninstall(Plugin $plugin)
    {
        $plugin->update([
            $plugin->status = 0
        ]);

        if ($plugin->unique_name == 'sitemap') {
            removeFileOrFolder('sitemap.xml');
        }

        if ($plugin->unique_name == 'google_adsense') {
            removeFileOrFolder('ads.txt');
        }

        if ($plugin->unique_name == 'robots') {
            removeFileOrFolder('robots.txt');
        }

        showToastr(__("$plugin->name is successfully uninstalled"));

        return back();
    }




    public function edit($plugin)
    {
        $plugin = Plugin::where('unique_name', $plugin)->firstOrFail();

        if ($plugin->unique_name == "sitemap") {
            return view('admin.plugins.sitemap')->with('plugin', $plugin);
        }
        return view('admin.plugins.edit')->with('plugin', $plugin);
    }


    public function sitemap(Request $request,   ImageService $imageService)
    {

        $plugin = Plugin::where('unique_name', 'sitemap')->first();

        $request->validate([
            'sitemap' => 'required|file|mimes:xml',
        ]);


        if ($request->has('sitemap')) {
            $file = $imageService->StoreSiteMap($request->sitemap);
            $plugin->update([
                'status' => 1
            ]);
        }

        showToastr(__("$plugin->name is successfully updated"));

        return back();
    }



    public function update(Request $request, Plugin $plugin)
    {

        $validation_rules = [];

        foreach ($plugin->code as $key => $value) {

            if (isset($value->skip_validation) && $value->skip_validation === true) {
                $validation_rules[$key] = 'nullable';
            } else {
                $validation_rules[$key] = 'required';
            }
        }

        $validatedData = $request->validate($validation_rules);


        $code = json_decode(json_encode($plugin->code), true);

        try {
            foreach ($code as $key => $val) {


                $code[$key]['value'] = $request->$key;

                if (isset($code[$key]['env']) && $code[$key]['env'] == 'true') {
                    updateEnvFile(strtoupper($key), $request->$key);
                }
            }
        } catch (\Exception $e) {
            Log::error($e->getMessage());
        }

        if ($plugin->unique_name == 'robots') {
            try {
                $myfile = fopen("robots.txt", "w") or die("Unable to open file!");
                $txt = $code['robots']['value'];
                fwrite($myfile, $txt);
                fclose($myfile);
            } catch (\Exception $e) {
                Log::error($e->getMessage());
            }
        }

        if ($plugin->unique_name == 'google_adsense') {
            try {
                $myfile = fopen("ads.txt", "w") or die("Unable to open file!");
                $txt = $code['adsense']['value'];
                fwrite($myfile, $txt);
                fclose($myfile);
            } catch (\Exception $e) {
                Log::error($e->getMessage());
            }
        }

        $plugin->update([
            'code' => $code,
            'status' => 1
        ]);

        showToastr(__("$plugin->name is successfully updated"));

        return back();
    }


    public function get_plugins()
    {
        $cacheKey = 'plugins';

        // Attempt to get data from the cache
        $newData = Cache::remember($cacheKey, now()->addHours(2), function () {

            return fetchData('get-ads', ['type' => 0]);
        });

        // If the data is not available or failed to fetch, return early
        if (!$newData || $newData['success'] !== true) {
            return null;
        }

        // Get the existing slugs from the log table
        $existingSlugs = Plugin::pluck('unique_name')->toArray();

        // Find new slugs that don't exist in the logs
        $newSlugs = array_diff(array_column($newData['data'], 'slug'), $existingSlugs);

        $data = array_filter($newData['data'], function ($item) use ($newSlugs) {
            return in_array($item['slug'], $newSlugs);
        });

        return $data;
    }

    public function store(Request $request)
    {
        try {
            if (class_exists('ZipArchive')) {
                if ($request->hasFile('plugin_zip_file')) {

                    $tempDir = 'temp_plugins/' . Str::random(10);
                    if (!is_dir(base_path($tempDir))) {
                        mkdir(base_path($tempDir), 0777, true);
                    }

                    $zipName = Str::random(10);
                    $storagePath = store_file([
                        'source' => $request->plugin_zip_file,
                        'path_to_save' => base_path($tempDir) . '/',
                        'specific_name' => $zipName
                    ]);


                    $zip = new ZipArchive();
                    if ($zip->open($storagePath['filename']) === true) {
                        $zip->extractTo(base_path($tempDir));
                        $zip->close();
                        removeFile($storagePath['filename']);
                    } else {
                        \File::deleteDirectory(base_path($tempDir));
                        showToastr(__('Unable to open file, please try again'));
                        return back();
                    }

                    $configPath = base_path($tempDir . '/config.json');

                    if (!file_exists($configPath)) {
                        \File::deleteDirectory(base_path($tempDir));
                        showToastr(__('Config file not found'));
                        return back();
                    }

                    $read_json = file_get_contents($configPath);
                    $read_json = preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $read_json);
                    $read_json = trim($read_json);
                    $config = json_decode($read_json, true);
                    if (json_last_error() !== JSON_ERROR_NONE) {
                        showToastr('JSON Error: ' . json_last_error_msg()); //error
                        return back();
                    }

                    try {
                        // Process the license key
                        $data = $this->installService->checkLicense($request->input('purchase_code'), $config['id']);

                        if (!$data['status'] || $data === null) {
                            showToastr($data['message']);
                            return back();
                        }
                    } catch (\Exception $e) {
                        showToastr(__('somting not working'));
                        return back();
                    }

                    if (!version_compare(env('SITE_VERSION'),  $config['required_version'], ">=")) {
                        \File::deleteDirectory(base_path($tempDir));

                        showToastr(__('This plugin requires version ' . $config['required_version'] . ' or higher'));
                        return back();
                    }


                    if (!in_array(config('lobage.script_name'), $config['script'])) {
                        \File::deleteDirectory(base_path($tempDir));
                        showToastr(__('This plugin is not compatible with your script.'));
                        return back();
                    }

                    if (!empty($config['files']['create']['directories'])) {
                        foreach ($config['files']['create']['directories'] as $directory) {
                            if (!is_dir(base_path($directory))) {
                                mkdir(base_path($directory), 0777, true);
                            }
                        }
                    }

                    if (!empty($config['files']['copy']['files'])) {
                        foreach ($config['files']['copy']['files'] as $file) {
                            $source = base_path($tempDir . '/' . $file['source']);
                            $destination = base_path($file['destination']);
                            if (file_exists($source)) {
                                copy($source, $destination);
                            }
                        }
                    }

                    $plugin = Plugin::where('unique_name', $config['alias'])->first();

                    if (!empty($config['database']['required_files'])) {
                        foreach ($config['database']['required_files'] as $sqlFile) {
                            $sqlPath = base_path($tempDir . '/' . $sqlFile);
                            if (file_exists($sqlPath)) {
                                try {
                                    DB::unprepared(file_get_contents($sqlPath));
                                } catch (\Exception $e) {
                                    showToastr(__('Database error (required): ') . $e->getMessage());
                                    return back();
                                }
                            }
                        }
                    }

                    if (!$plugin && !empty($config['database']['initial_files'])) {
                        foreach ($config['database']['initial_files'] as $sqlFile) {
                            $sqlPath = base_path($tempDir . '/' . $sqlFile);
                            if (file_exists($sqlPath)) {
                                try {
                                    DB::unprepared(file_get_contents($sqlPath));
                                } catch (\Exception $e) {
                                    showToastr(__('Database error (initial): ') . $e->getMessage());
                                    return back();
                                }
                            }
                        }
                    }

                    $plugin = Plugin::updateOrCreate(
                        ['unique_name' => $config['alias']], // Use 'unique_name' for the alias
                        [
                            'name' => $config['name'], // Map 'name' directly
                            'unique_name' => $config['alias'], // Map 'alias' to 'unique_name'
                            'version' => $config['version'], // Map 'version' directly
                            'status' => $config['status'] === 'active' ? 1 : 0, // Convert 'status' to boolean
                            'logo' => $config['thumbnail'], // Map 'thumbnail' to 'logo'
                            //'path' => $config['path'], // Map 'path' directly
                            'action' => $config['action'], // Map 'action' directly
                            // Optional fields (can be null or use defaults)
                            'tag' => $config['tag'],
                            'url' => $config['url'],
                            'description' => $config['description'],
                            'code' => $config['code'],
                            'license' => $request->purchase_code,
                            'is_featured' => 0, // Default value
                        ]
                    );

                    if (!empty($config['files']['remove'])) {
                        $this->removeFilesAndDirectories($config['files']['remove']);
                    }

                    File::deleteDirectory(base_path($tempDir));

                    showToastr(__('Plugin installed successfully'));
                    return redirect(route('admin.plugins.show', $plugin->id));
                }
            } else {
                showToastr(__('ZipArchive extension is not enabled'));
                return back();
            }
        } catch (Exception $e) {
            showToastr(__('Something went wrong: ') . $e->getMessage());
            return back();
        }
    }

    private function removeFilesAndDirectories($removeConfig)
    {

        if (!empty($removeConfig['files'])) {
            foreach ($removeConfig['files'] as $file) {
                $filePath = base_path($file);
                if (file_exists($filePath)) {
                    unlink($filePath);
                }
            }
        }

        if (!empty($removeConfig['directories'])) {
            foreach ($removeConfig['directories'] as $directory) {
                $dirPath = base_path($directory);
                if (is_dir($dirPath)) {
                    \File::deleteDirectory($dirPath);
                }
            }
        }
    }
}