<?php


namespace Lobage\Planify\Traits;


use Lobage\Planify\Helpers\CarbonHelper;
use Lobage\Planify\Services\Period;

trait HasSubscriptionPeriod
{
    /**
     * Subscription total duration in specified interval
     * @param string $interval
     * @return int
     * @throws \Exception
     */
    public function getSubscriptionTotalDurationIn(string $interval): int
    {
        $subscriptionPeriod = new Period($this->invoice_interval, $this->invoice_period);
        return $subscriptionPeriod->getStartDate()->{CarbonHelper::diffIn($interval)}($subscriptionPeriod->getEndDate());
    }
}
