<?php

namespace App\Http\Controllers\Frontend;

use Auth;
use Hash;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Services\ImageService;
use Lobage\Planify\Models\Plan;
use App\Http\Controllers\Controller;
use Lobage\Planify\Models\PlanSubscription;
use App\Http\Requests\Frontend\UpdateUserRequest;

class BillingController extends Controller
{


    public function billing()
    {

        setMetaTags(translate('Blog', 'seo'));
        generateSeoMeta(translate('Billing'));
        $user = Auth::user();
        $transactions = Transaction::with('plan')->where('user_id', $user->id)->orderBy('created_at', 'DESC')->paginate(10);
        $subscription = $user->subscription('main');


        return view()->theme('billing')->with('subscription', $subscription)->with('transactions', $transactions);;
    }


    public function index()
    {
        setMetaTags(translate('Billing', 'seo'));
        $user = Auth::user();
        $transactions = Transaction::with('plan')->where('user_id', $user->id)->orderBy('created_at', 'DESC')->paginate(10);
        $subscription = $user->subscription('main');

        $trialEnded = PlanSubscription::findEndedTrial()->whereNull('starts_at')->get();

        return view('frontend.user.billing.index')->with('subscription', $subscription)->with('transactions', $transactions);
    }

    public function plans()
    {
        setMetaTags(translate('Plans', 'seo'));
        $monthly_plans = Plan::where('is_active', '1')->where('invoice_interval', 'month')->orderBy('tier')->get();
        $lifetime_plans = Plan::where('is_active', '1')->where('is_lifetime', '1')->whereNotIn('tag', ['free', 'guest'])->orderBy('tier')->get();
        $yearly_plans = Plan::where('is_active', '1')->where('invoice_interval', 'year')->whereNotIn('tag', ['free', 'guest'])->where('is_lifetime', 0)->orderBy('tier')->get();
        $free_plan = Plan::where('is_active', '1')->where('tag', 'free')->first();

        $user = Auth::user();
        $plan_id = 0;

        if ($user->subscriptions->count() > 0) {
            $plan_id = $user->subscription('main')->plan_id;
        }

        return view('frontend.user.billing.plans', compact('user', 'plan_id', 'monthly_plans', 'yearly_plans', 'lifetime_plans', 'free_plan'));
    }
}
