<?php

namespace Lobage\Planify\Exceptions;

class InvalidPlanSubscription extends LaravelSubbyException
{
    public function __construct($subscriptionTag = "")
    {
        $message = "Subscription '{$subscriptionTag}' not found.";

        parent::__construct($message);
    }
}
