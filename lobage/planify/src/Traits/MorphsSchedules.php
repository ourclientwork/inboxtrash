<?php

namespace Lobage\Planify\Traits;

trait MorphsSchedules
{
    /**
     * Get all schedules.
     */
    public function schedules()
    {
        return $this->morphMany(config('planify.models.plan_subscription_schedule'), 'scheduleable');
    }
}
