<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;

echo "Checking IMAP configurations...\n";

$imaps = Imap::all();
$service = new TrashMailService();

foreach ($imaps as $imap) {
    echo "--------------------------------------------------\n";
    echo "ID: " . $imap->id . "\n";
    echo "Host: " . $imap->host . "\n";
    echo "Port: " . $imap->port . "\n";
    echo "Username: " . $imap->username . "\n";
    echo "Encryption: " . $imap->encryption . "\n";

    // Test 1: As configured
    echo "Test 1: Connection as configured (" . $imap->encryption . ")\n";
    try {
        // Set timeout short to avoid long hang
        // We can't easily change timeout in the service without modifying it,
        // but let's hope it fails fast or we rely on observation.
        // Actually, we can assume the previous hang is enough evidence, but let's try.
        // We'll skip the 'tls' test if we think it hangs, but let's try 'ssl' directly.
    } catch (\Exception $e) {
        // ...
    }

    // Test 2: Forced SSL
    echo "Test 2: Forced SSL on Port 993\n";
    $clone = clone $imap;
    $clone->encryption = 'ssl';

    try {
        $client = $service->connection(false, $clone);
        $client->connect();
        echo "SUCCESS: Connected using SSL!\n";
    } catch (\Exception $e) {
        echo "ERROR (SSL): " . $e->getMessage() . "\n";
    }
}
