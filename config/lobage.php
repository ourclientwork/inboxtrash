<?php

declare(strict_types=1);

return [

    /* The line `'admin' => env('PREFIX_ADMIN', 'admin')` is defining a admin panel.*/

    'script_name' => 'trashmails_saas',
    'admin' => env('ADMIN_PATH', 'admin'),
    'version' => env('SITE_VERSION', '1'),
    'current_theme' => env('CURRENT_THEME', 'basic'),
    'admin_path' =>  env('ADMIN_PATH', 'admin') . "/dashboard",
    'default_avatar' => 'assets/img/default-user.png',
    'api_docs' => 'docs url',
    'id' => 2001,
    'support' => "https://t.me/lobage_bot",
    'api' => "https://api.lobage.com/api/",
    'api_v2' => "https://api2.lobage.com/api/",
    'translate' => "https://translate.lobage.com/api/",


    //Script
    'attachment_path' =>  public_path('temp/attachments/'),
    'messages_eml_path' => "temp/messages/",


    // Saas
    'main_subscription_tag' => 'main',
    'fallback_plan_tag' => null,


    'shortcodes' => [
        'blog' => 'Blog Link',
        'contact' => 'Contact Us page',
        // Add more shortcodes as needed
    ],


];