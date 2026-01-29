<?php

declare(strict_types=1);

namespace Lobage\Planify\Services\PaymentMethods;

use Lobage\Planify\Contracts\PaymentMethodService;
use Lobage\Planify\Traits\IsPaymentMethod;

class Free implements PaymentMethodService
{
    use IsPaymentMethod;

    /**
     * Charge desired amount
     * @return void
     */
    public function charge()
    {
        // Nothing is charged, no exception is raised
    }
}
