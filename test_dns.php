<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Domain;

echo "Checking DNS MX records for all active domains...\n";
echo "Target Mail Server (expected): mail.inboxtrash.com\n\n";

$domains = Domain::where('status', 1)->pluck('domain')->toArray();

foreach ($domains as $domain) {
    echo "--------------------------------------------------\n";
    echo "Domain: " . $domain . "\n";

    $mxRecords = [];
    $mxWeights = [];

    // Perform DNS lookup for MX records
    if (getmxrr($domain, $mxRecords, $mxWeights)) {
        for ($i = 0; $i < count($mxRecords); $i++) {
            $isCorrect = ($mxRecords[$i] === 'mail.inboxtrash.com') ? "  [OK]" : "  [WARNING: Does not match expected]";
            echo "  MX Record: " . $mxRecords[$i] . " (Priority: " . $mxWeights[$i] . ") " . $isCorrect . "\n";
        }
    } else {
        echo "  [ERROR] No MX records found for this domain!\n";
    }
}
echo "--------------------------------------------------\n";
echo "DNS Check Complete.\n";
