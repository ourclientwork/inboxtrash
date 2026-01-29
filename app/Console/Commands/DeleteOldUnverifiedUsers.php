<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;

class DeleteOldUnverifiedUsers extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:delete-old-unverified-users';

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
        $d = getSetting("auto_delete_unverified_users");
        if ($d != 0) {

            $count = User::query()
                ->whereNull('email_verified_at')
                ->where('created_at', '<', now()->subDays($d))
                ->delete();
            $this->comment("Deleted {$count} unverified users.");
            $this->info('All done!');
        }
    }
}