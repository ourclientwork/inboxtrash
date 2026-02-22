<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;

echo "Checking IMAP mailbox for emails...\n";

$imap = Imap::first();
if (!$imap) {
    echo "No IMAP account found.\n";
    exit;
}

$service = new TrashMailService();

try {
    $client = $service->connection(true, $imap); // Use masking
    $client->connect();
    echo "SUCCESS: Connected to " . $imap->host . "\n";

    $folder = $client->getFolderByName('INBOX');
    echo "Selected INBOX.\n";

    // Test fetch all recent emails just to see if ANY exist
    $messages = $folder->query()->since(\Carbon\Carbon::now()->subDays(2)->format('d-M-Y'))->get();

    echo "Total recent messages across all addresses: " . $messages->count() . "\n";

    // Dump first 5
    $count = 0;
    foreach ($messages as $message) {
        if ($count >= 5) break;
        $count++;

        $to = "Unknown";
        if (isset($message->getAttributes()['to'][0])) {
            $to = $message->getAttributes()['to'][0]->mail;
        }

        $subject = "Unknown";
        if (isset($message->getAttributes()['subject'][0])) {
            $subject = $message->getAttributes()['subject'][0];
        }

        echo "- Email to: " . $to . " | Subject: " . $subject . "\n";
    }
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
