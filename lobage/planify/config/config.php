<?php

declare(strict_types=1);

return [
    'main_subscription_tag' => 'main',
    'fallback_plan_tag' => null,
    // Database Tables
    'tables' => [
        'plans' => 'plans',
        'plan_combinations' => 'plan_combinations',
        'plan_features' => 'plan_features',
        'plan_subscriptions' => 'plan_subscriptions',
        'plan_subscription_features' => 'plan_subscription_features',
        'plan_subscription_schedules' => 'plan_subscription_schedules',
        'plan_subscription_usage' => 'plan_subscription_usage',
    ],

    // Models
    'models' => [
        'plan' => \Lobage\Planify\Models\Plan::class,
        'plan_combination' => \Lobage\Planify\Models\PlanCombination::class,
        'plan_feature' => \Lobage\Planify\Models\PlanFeature::class,
        'plan_subscription' => \Lobage\Planify\Models\PlanSubscription::class,
        'plan_subscription_feature' => \Lobage\Planify\Models\PlanSubscriptionFeature::class,
        'plan_subscription_schedule' => \Lobage\Planify\Models\PlanSubscriptionSchedule::class,
        'plan_subscription_usage' => \Lobage\Planify\Models\PlanSubscriptionUsage::class,
    ],

    'services' => [
        'payment_methods' => [
            'free' => \Lobage\Planify\Services\PaymentMethods\Free::class
        ]
    ]
];
