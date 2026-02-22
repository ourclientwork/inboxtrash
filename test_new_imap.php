<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Imap;
use App\Services\TrashMailService;

$service = new TrashMailService();

$imap = new Imap();
$imap->host = "node-asia-2.boostedhost-dns.com";
$imap->username = "support@inboxtrash.com";
$imap->password = "haMXJw8qOA5HJL\$w";
$imap->encryption = "ssl";
$imap->port = 993;
$imap->validate_certificates = 0;

try {
    $client = $service->connection(false, $imap);
    $client->connect();
    echo "SUCCESS: Connected using new credentials!\n";
} catch (\Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
