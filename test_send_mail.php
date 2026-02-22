<?php

require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\Mail;

echo "Sending test emails...\n";

// Test 1: Direct email to the main account
try {
    echo "Sending to me@dev-shadin.com (Direct)... ";
    Mail::raw('This is a DIRECT test email.', function ($message) {
        $message->to('me@dev-shadin.com')
            ->subject('Test: Direct Email');
    });
    echo "Sent.\n";
} catch (\Exception $e) {
    echo "Failed: " . $e->getMessage() . "\n";
}

// Test 2: Catch-All email to a random alias
$randomAlias = 'test-' . time() . '@dev-shadin.com';
try {
    echo "Sending to $randomAlias (Catch-All)... ";
    Mail::raw("This is a CATCH-ALL test email sent to $randomAlias.", function ($message) use ($randomAlias) {
        $message->to($randomAlias)
            ->subject('Test: Catch-All Email');
    });
    echo "Sent.\n";
} catch (\Exception $e) {
    echo "Failed: " . $e->getMessage() . "\n";
}

echo "\nEmails sent. Please wait a few seconds and run 'php debug_inbox.php' again to see if they arrived.\n";
