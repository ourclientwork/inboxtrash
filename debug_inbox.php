<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;
use Webklex\PHPIMAP\ClientManager;

echo "Inspecting INBOX...\n";

$imap = Imap::first();
if (!$imap) {
    echo "No IMAP account found.\n";
    exit;
}

$service = new TrashMailService();
$client = $service->connection(false, $imap);
$client->connect();

$folders = $client->getFolders();

foreach ($folders as $folder) {
    echo "Folder: " . $folder->name . "\n";
    try {
        echo "  Messages: " . $folder->messages()->all()->count() . "\n";
    } catch (\Exception $e) {
        echo "  Error getting count: " . $e->getMessage() . "\n";
    }
}
