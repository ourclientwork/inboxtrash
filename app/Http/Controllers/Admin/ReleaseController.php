<?php

namespace App\Http\Controllers\Admin;


use App\Models\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;


class ReleaseController extends Controller
{

    public function get_data()
    {
        $cacheKey = 'broadcasts_data';

        // Attempt to get data from the cache
        $newData = Cache::remember($cacheKey, now()->addHours(2), function () {

            return fetchData('get-broadcasts');
        });

        // If the data is not available or failed to fetch, return early
        if (!$newData || $newData['success'] !== true) {
            return null;
        }

        Cache::forget('existing_slugs_release');

        // Get the existing slugs from the log table
        $existingSlugs = Log::where('key', 'release')->pluck('value')->toArray();

        // Find new slugs that don't exist in the logs
        $newSlugs = array_diff(array_column($newData['data'], 'slug'), $existingSlugs);

        if (count($newSlugs) === 1) {
            $newSlugs = array_values($newSlugs); // Converts to a numeric array
        }

        // Count the number of new slugs
        $newSlugsCount = count($newSlugs);

        if ($newSlugsCount > 0) {

            if (!empty($newSlugs)) {
                $newSlugsString = implode(',', $newSlugs);
            } else {
                $newSlugsString = ''; // If no new slugs, set an empty string
            }

            $id = config('lobage.id');

            $response = Http::get(config('lobage.api') . 'get-broadcasts?id=' . $id . '&slug=' . $newSlugsString);

            // If the primary response is unsuccessful or null, try the backup API
            if (!$response->successful() || is_null($response->json())) {
                $response = Http::get(config('lobage.api_v2') . 'get-broadcasts?id=' . $id . '&slug=' . $newSlugsString);
            }

            // Return the final response data (either primary or backup)
            return $response->successful() ? $response->json() : null;

            if (!$response || $response['success'] !== true) {
                return null;
            }

            foreach ($newSlugs as $slug) {
                Log::create([
                    'key' => 'release',
                    'value' => $slug,
                ]);
            }

            return true;
        }
    }
}
