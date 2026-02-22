<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Models\Domain;
use App\Services\TrashMailService;

// Check Domains
echo "Checking configured domains...\n";
$domains = Domain::all();
foreach ($domains as $d) {
    echo "Domain: " . $d->domain . " (Type: " . $d->type . ")\n";
}
echo "--------------------------------------------------\n";

// Test New Credentials
echo "Testing IMAP with USER PROVIDED credentials...\n";
$host = "mail.dev-shadin.com";
$user = "me@dev-shadin.com";
$pass = "me@dev-shadin.com2200"; // Escaped $ sign
$port = 465;
$encryption = "ssl";



echo "Host: $host\n";
echo "Username: $user\n";
echo "Port: $port\n";

$service = new TrashMailService();
$imap = new Imap();
$imap->host = $host;
$imap->port = $port;
$imap->encryption = $encryption;
$imap->username = $user;
$imap->password = $pass;
$imap->validate_certificates = false; // Start safe
$imap->id = 888;

try {
    $client = $service->connection(false, $imap);
    $client->connect();
    echo "SUCCESS: Connected to $host!\n";
    $folders = $client->getFolders();
    echo "Folders found: " . $folders->count() . "\n";
    foreach ($folders as $f) {
        echo " - " . $f->name . " (" . $f->messages()->all()->count() . ")\n";
    }
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
