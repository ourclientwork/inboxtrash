<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;

echo "Testing connection with .env credentials...\n";
echo "Host: mail.dev-shadin.com\n";
echo "Username: me@dev-shadin.com\n";
echo "Port: 993 (SSL)\n";

$service = new TrashMailService();

// Create a temporary Imap object
$imap = new Imap();
$imap->host = "mail.dev-shadin.com";
$imap->port = 993;
$imap->encryption = "ssl";
$imap->validate_certificates = false; // Start with false to avoid CN mismatch blocking us
$imap->username = "me@dev-shadin.com";
$imap->password = "me@dev-shadin.com2200";
$imap->id = 999; // Fake ID

echo "--------------------------------------------------\n";
echo "Test 1: Validate Cert = false, Encryption = ssl, Port = 993\n";
try {
    $client = $service->connection(false, $imap);
    $client->connect();
    echo "SUCCESS: Connected!\n";
    $folders = $client->getFolders();
    echo "Folders: " . $folders->count() . "\n";
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}

echo "--------------------------------------------------\n";
echo "Test 2: Validate Cert = true, Encryption = ssl, Port = 993\n";
$imap->validate_certificates = true;
try {
    $client = $service->connection(false, $imap);
    $client->connect();
    echo "SUCCESS: Connected!\n";
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}

echo "--------------------------------------------------\n";
echo "Test 3: Encryption = tls, Port = 993 (Just in case)\n";
$imap->encryption = 'tls';
try {
    $client = $service->connection(false, $imap);
    $client->connect();
    echo "SUCCESS: Connected!\n";
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
