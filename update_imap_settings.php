<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;

echo "Updating IMAP configurations...\n";

// Fetch the first IMAP account (Assuming ID 1 based on previous output)
$imap = Imap::first();

if (!$imap) {
    echo "No IMAP account found to update.\n";
    exit;
}

echo "Current Settings:\n";
echo "Host: " . $imap->host . "\n";
echo "Username: " . $imap->username . "\n";

// New Settings
$newHost = 'mail.dev-shadin.com';
$newUser = 'me@dev-shadin.com';
$newPass = 'me@dev-shadin.com2200';
$newPort = 993;
$newEncryption = 'ssl';
$newValidateCert = false;

echo "\nApplying New Settings:\n";
echo "Host: $newHost\n";
echo "Username: $newUser\n";
echo "Port: $newPort\n";
echo "Encryption: $newEncryption\n";
echo "Validate Cert: " . ($newValidateCert ? 'true' : 'false') . "\n";

$imap->host = $newHost;
$imap->username = $newUser;
$imap->password = $newPass;
$imap->port = $newPort;
$imap->encryption = $newEncryption;
$imap->validate_certificates = $newValidateCert;
$imap->save();

echo "\nSettings saved.\n";

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
