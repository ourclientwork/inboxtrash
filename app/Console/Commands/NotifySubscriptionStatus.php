<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Lobage\Planify\Models\PlanSubscription;

class NotifySubscriptionStatus extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:subscription-status';
    protected $description = 'Notify users about subscription status';



    public function handle()
    {


        $reminder_days = getSetting("user_plan_expiry_reminder");

        // Notify users whose subscription is ending in $reminder_days days
        $expiring = PlanSubscription::findEndingPeriod($reminder_days)->get();

        foreach ($expiring as $subscription) {

            if (!$subscription->isLifetime() && $subscription->notify != "user_plan_expiry_reminder") {

                $short_codes = [
                    'user_fullname'   => $subscription->subscriber->getFullName(),
                    'plan_name'      => $subscription->plan->name,
                    'expiry_date'      => ToDate($subscription->ends_at),
                    'renewal_url'      => route('checkout', encode_hash($subscription->plan->id)),
                    'website_name'    => config('app.name'),
                    'website_url'     => config('app.url'),
                ];

                sendEmail($subscription->subscriber->email, "user_plan_expiry_reminder", $short_codes, true);

                $subscription->notify = 'user_plan_expiry_reminder';
                $subscription->save();
            }
        }


        // Notify users whose subscription has ended
        $ended = PlanSubscription::findEndedPeriod()->get();
        foreach ($ended as $subscription) {

            if (!$subscription->isLifetime() && $subscription->notify != "user_plan_expired") {

                $short_codes = [
                    'user_fullname'   => $subscription->subscriber->getFullName(),
                    'plan_name'      => $subscription->plan->name,
                    'expiry_date'      => ToDate($subscription->ends_at),
                    'renewal_url'      => route('checkout', encode_hash($subscription->plan->id)),
                    'website_name'    => config('app.name'),
                    'website_url'     => config('app.url'),
                ];

                sendEmail($subscription->subscriber->email, "user_plan_expired", $short_codes, true);

                $subscription->notify = 'user_plan_expiry_reminder';
                $subscription->save();
            }
        }

        // Notify users whose trial is ending in $reminder_days days
        $trialExpiring = PlanSubscription::findEndingTrial($reminder_days)->get();
        foreach ($trialExpiring as $subscription) {

            if (!$subscription->isLifetime() && $subscription->notify != "user_trial_expiry_reminder") {

                $short_codes = [
                    'user_fullname'   => $subscription->subscriber->getFullName(),
                    'plan_name'      => $subscription->plan->name,
                    'expiry_date'      => ToDate($subscription->trial_ends_at),
                    'upgrade_url'      => route('checkout', encode_hash($subscription->plan->id)),
                    'website_name'    => config('app.name'),
                    'website_url'     => config('app.url'),
                ];


                sendEmail($subscription->subscriber->email, "user_trial_expiry_reminder", $short_codes, true);

                $subscription->notify = 'user_trial_expiry_reminder';
                $subscription->save();
            }
        }

        // Notify users whose trial has ended
        $trialEnded = PlanSubscription::findEndedTrial()->whereNull('starts_at')->get();
        foreach ($trialEnded as $subscription) {
            if (!$subscription->isLifetime() && $subscription->notify != "user_trial_expired") {

                $short_codes = [
                    'user_fullname'   => $subscription->subscriber->getFullName(),
                    'plan_name'      => $subscription->plan->name,
                    'expiry_date'      => ToDate($subscription->trial_ends_at),
                    'upgrade_url'      => route('checkout', encode_hash($subscription->plan->id)),
                    'website_name'    => config('app.name'),
                    'website_url'     => config('app.url'),
                ];

                sendEmail($subscription->subscriber->email, "user_trial_expired", $short_codes, true);

                $subscription->notify = 'user_trial_expired';
                $subscription->save();
            }
        }
    }
}
