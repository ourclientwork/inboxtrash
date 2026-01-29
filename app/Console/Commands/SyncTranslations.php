<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class SyncTranslations extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'translations:sync';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('🔍search for translate()...');

        $paths = [
            resource_path('views'),
            app_path(),
            base_path('routes'),
            base_path('lang'),
        ];

        $pattern = '/translate\(\s*[\'"](.+?)[\'"](?:\s*,\s*[\'"](.+?)[\'"])?/';

        $found = [];

        foreach ($paths as $path) {
            $files = \Illuminate\Support\Facades\File::allFiles($path);

            foreach ($files as $file) {
                $content = $file->getContents();
                if (preg_match_all($pattern, $content, $matches, PREG_SET_ORDER)) {
                    foreach ($matches as $match) {
                        $key = $match[1];
                        $group = $match[2] ?? 'general';

                        $found[] = compact('key', 'group');
                    }
                }
            }
        }

        $this->info("📝 we find" . count($found));
        $count = 0;

        foreach ($found as $item) {
            translate($item['key'], $item['group'], null, $item['key']);
            $count++;
        }

        $this->info("✅");
    }
}
