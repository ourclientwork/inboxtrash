<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;

echo "Updating IMAP configurations...\n";

// Fetch the first IMAP account (Assuming ID 1)
$imap = Imap::first();

if (!$imap) {
    echo "No IMAP account found to update.\n";
    exit;
}

// New Settings
$newHost = 'node-asia-2.boostedhost-dns.com';
$newUser = 'support@inboxtrash.com';
$newPass = 'haMXJw8qOA5HJL$w';
$newPort = 993;
$newEncryption = 'ssl';
$newValidateCert = false;

echo "\nApplying New Settings:\n";
echo "Host: $newHost\n";
echo "Username: $newUser\n";
echo "Port: $newPort\n";

$imap->host = $newHost;
$imap->username = $newUser;
$imap->password = $newPass;
$imap->port = $newPort;
$imap->encryption = $newEncryption;
$imap->validate_certificates = $newValidateCert;
$imap->save();

echo "\nSettings saved in database!\n";

echo "\nTesting connection with saved settings...\n";
$service = new TrashMailService();
try {
    $client = $service->connection(false, $imap);
    $client->connect();
    echo "SUCCESS: Connected and Authenticated!\n";
    $folders = $client->getFolders();
    echo "Folders found: " . $folders->count() . "\n";
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
