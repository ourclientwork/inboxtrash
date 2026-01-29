<?php

namespace App\Http\Controllers\Frontend;

use Auth;
use App\Models\Plugin;
use App\Models\Transaction;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Services\ImageService;
use App\Services\CouponService;
use Lobage\Planify\Models\Plan;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Validation\ValidationException;
use App\Http\Controllers\Payments\PaypalController;
use App\Http\Controllers\Payments\StripeController;

class CheckoutController extends Controller
{

    public function index($hash, Request $request, CouponService $couponService)
    {

        $id = decode_hash($hash);
        if (empty($id)) {
            return $this->redirectToPlans();
        }

        $plan = Plan::where('id', $id)->where('is_active', 1)->firstOrFail();
        $user = Auth::user();

        if ($user->subscriptions->count() == 0) {

            if ($plan->isFree() || $plan->hasTrial()) {
                return $this->handleFreePlan($user, $plan);
            } else {
                return $this->handlePaidPlan($user, $plan, $request, $couponService);
            }
        }



        if ($user->subscription('main')->plan_id == $plan->id  && $plan->isFree()) {
            return $this->alreadySubscribedToFreePlan();
        }



        $featuresToCheck = [
            'domains' => translate('You are currently using more domains than allowed in the selected plan. Please delete some domains before switching.', 'alerts'),
            'messages' => translate('You are currently using more favorite messages than allowed in the selected plan. Please delete some messages before switching.', 'alerts'),
            // Add more features here as needed
        ];

        $errors = [];

        foreach ($featuresToCheck as $feature => $errorMessage) {
            $currentUsage = $user->subscription('main')->getFeatureUsage($feature);
            $newPlanLimit = $plan->getFeatureByTag($feature)->value;

            if ($newPlanLimit !== true && $newPlanLimit != -1 && $currentUsage > $newPlanLimit) {
                $errors[] = $errorMessage;
            }
        }

        if (!empty($errors)) {
            foreach ($errors as $error) {
                showToastr($error, 'error');
            }
            return $this->redirectToPlans();
        }


        $currentUsage = $user->subscription('main')->getFeatureUsage('domains');
        $newPlanLimit = $plan->getFeatureByTag('domains')->value;

        if ($newPlanLimit !== true && $newPlanLimit != -1 && $currentUsage > $newPlanLimit) {
            showToastr(translate('You are currently using more domains than allowed in the selected plan. Please delete some domains before switching.', 'alerts'), 'error');
            return $this->redirectToPlans();
        }

        $currentUsage = $user->subscription('main')->getFeatureUsage('messages');
        $newPlanLimit = $plan->getFeatureByTag('messages')->value;

        if ($newPlanLimit !== true && $newPlanLimit != -1 && $currentUsage > $newPlanLimit) {
            showToastr(translate('You are currently using more favorite messages than allowed in the selected plan. Please delete some messages before switching.', 'alerts'), 'error');
            return $this->redirectToPlans();
        }


        if ($plan->isFree()) {
            return $this->handleFreePlan($user, $plan);
        } else {
            return $this->handlePaidPlan($user, $plan, $request, $couponService);
        }
    }

    private function redirectToPlans()
    {
        return redirect(route('plans'));
    }

    private function handleFreePlan($user, $plan)
    {

        $transaction = Transaction::create([
            'user_id' => $user->id,
            'transaction_id' => strtoupper(Str::random(12)),
            'plan_id' =>  $plan->id,
            'payment_id' => $plan->isFree() ? "FREE-" . strtoupper(Str::random(5))  : 'TRIAL-' . strtoupper(Str::random(5)),
            'amount' => 0,
            'gateway' => $plan->isFree() ? "Free"  : 'Trial',
            'coupon' => 0,
            'fees' => 0,
            'currency' => getSetting('currency_code'),
            'interval' => $plan->is_lifetime ? 'Lifetime' : ucfirst($plan->invoice_interval) . "ly",
            'status' => 1,
            'coupon_code' => null,
            'paid_at' => now()

        ]);
        newSubscription($user, $plan);
        showToastr(translate('You have successfully subscribed', 'alerts'));
        return redirect(route('billing'));
    }

    private function alreadySubscribedToFreePlan()
    {
        showToastr(translate('You are already subscribed to the free plan', 'alerts'), 'error');
        return $this->redirectToPlans();
    }

    private function handlePaidPlan($user, $plan, Request $request, CouponService $couponService)
    {
        $gateways = $this->checkGateways();

        if (!$gateways) {
            showToastr(translate('No payment method available at the moment', 'alerts'), 'error');
            return $this->redirectToPlans();
        }

        if (!$this->checkProfile($user)) {
            showToastr(translate('Please Complete your Profile', 'alerts'), 'error');
            return redirect(route('settings'));
        }

        $discount = 0;
        $coupon_code = null;

        if ($request->has('discount') && $request->discount != null) {

            $coupon_code = $request->discount;
            try {
                $discount = $couponService->applyCoupon($coupon_code, $plan);
            } catch (ValidationException $e) {
                return back()->withErrors($e->errors())->withInput();
            } catch (\Exception $e) {
                showToastr(translate('An unexpected error occurred', 'alerts'), 'error');
                return back();
            }
        }

        $tax = getTax()['rate'] ?? 0;

        $calculate_tax = calculateTax($plan->price - $discount, $tax);

        setMetaTags(translate('Checkout', 'fantastic'));
        return view('frontend.user.billing.checkout', compact('user', 'plan', 'gateways', 'discount', 'coupon_code', 'tax', 'calculate_tax'));
    }


    public function checkGateways()
    {
        $gateways = Plugin::where('status', '1')->where('tag', 'gateways')->get();
        if ($gateways->count() == 0) {
            return false;
        }

        return $gateways;
    }

    public function checkProfile($user)
    {
        if (empty($user->firstname) || empty($user->lastname) || empty($user->email)) {
            return false;
        }
        return true;
    }

    public function pay(Request $request, CouponService $couponService, ImageService $imageService)
    {

        $coupon_code = null;
        $discount = 0;
        $id = decode_hash($request->hash);
        if (empty($id)) {
            return redirect(route('plans'));
        }

        $plan = Plan::where('id', $id)->where('is_active', 1)->firstOrFail();
        $user = Auth::user();

        if ($request->has('discount') && $request->discount != null) {

            $coupon_code = $request->discount;
            try {
                $discount = $couponService->applyCoupon($coupon_code, $plan, true);
            } catch (ValidationException $e) {
                return back()->withErrors($e->errors())->withInput();
            } catch (\Exception $e) {
                showToastr(translate('An unexpected error occurred', 'alerts'), 'error');
                return back();
            }
        }

        $tax = getTax()['rate'] ?? 0;
        $tax_name = getTax()['name'] ?? null;
        $calculate_tax = calculateTax($plan->price - $discount, $tax);
        $total = total($plan->price, $calculate_tax, $discount);
        $currency = getSetting('currency_code');

        $transaction = Transaction::create([
            'user_id' => $user->id,
            'plan_id' => $plan->id,
            'transaction_id' => strtoupper(Str::random(12)),
            'payment_id' => null,
            'payer_id' => null,
            'gateway' => $request->gateway,
            'amount' => $total,
            'plan_price' => $plan->price,
            'discount_amount' => $discount,
            'coupon_code' => $coupon_code,
            'fees' => 0,
            'currency' => $currency,
            'interval' => $plan->is_lifetime ? 'Lifetime' : ucfirst($plan->invoice_interval) . "ly",
            'status' => 0, // unpaid
            'tax_name' => $tax_name,
            'tax_rate' =>  $tax,
            'tax_amount' => $calculate_tax,
            'payment_proof' => null,
            'ip_address' => get_user_ip(),
            'cancellation_reason' => null,
            'payment_link' => null,
            'paid_at' => null,
        ]);


        if ($total == 0) {
            $transaction->update(['payment_id' => 'None', 'paid_at' => now(), 'status' => 1]);
            newSubscription($user, $plan);
            showToastr(translate('You have successfully subscribed', 'alerts'));
            return redirect(route('billing'));
        }


        $gateway = match ($request->gateway) {
            'paypal' => new PaypalController,
            'stripe' => new StripeController,
            default => null
        };

        if (!$gateway) {
            showToastr("Invalid payment gateway", 'error');
            return back();
        }

        $response = $gateway->pay($transaction);

        if ($response['success']) {
            $transaction->update(['payment_id' => $response['payment_id']]);
            return Redirect::to($response['redirect_url']);
        } else {
            showToastr($response['message'], 'error');
            Log::info($response);
            return back();
        }
    }



    //For Webhook
    public function handle(Request $request, $gateway)
    {
        $service = match ($gateway) {
            'paypal' => new PaypalController(),
            'stripe' => new StripeController(),
            default => null
        };

        if (!$service) {
            return response()->json(['error' => 'Invalid payment gateway'], 400);
        }

        $result = $service->verifyWebhook($request);

        if ($result['success']) {

            $transaction =  $result['process_data'];

            newSubscription($transaction->user, $transaction->plan, $gateway);

            $msg = "{$transaction->user->getFullName()} has subscribed to the {$transaction->plan->name} plan.";

            sendNotification($msg, 'coin', true, $transaction->user_id, route('admin.transactions.show', $transaction->id));

            $short_codes = [
                'user_fullname'   => $transaction->user->getFullName(),
                'payment_amount'     => $transaction->amount . " " . $transaction->currency,
                'transaction_id'      => $transaction->transaction_id,
                'plan_name'      => $transaction->plan->name . " Plan (" . $transaction->interval . ")",
                'payment_date'      => $transaction->paid_at,
                'website_name'    => config('app.name'),
                'website_url'     => config('app.url'),
            ];

            sendEmail($transaction->user->email, "user_payment_confirmation", $short_codes, true);

            return response()->json(['success' => true]);
        }

        return response()->json(['success' => true], 404);
    }



    public function payment_verify(Request $request, $payment)
    {
        $service = match ($payment) {
            'paypal' => new PaypalController(),
            'stripe' => new StripeController(),
            default => null
        };

        if (!$service) {
            return response()->json(['error' => 'Invalid payment gateway'], 400);
        }

        $result = $service->verify($request);

        if ($result['success']) {
            $transaction = Transaction::where('payment_id', $result['payment_id'])->first();

            if ($transaction && $transaction->status != 1) {
                $transaction->update([
                    'status' => 2,
                ]);
            }

            setMetaTags(translate('Processing Your Payment', 'seo'));
            return view('frontend.user.billing.waiting-confirmation');
        }

        $transaction = Transaction::where('payment_id', $result['payment_id'])->first();

        if ($transaction && $transaction->status != 1) {
            $transaction->update([
                'status' => 3,
            ]);
        }

        showToastr($result['message'], 'error');
        return redirect(route('billing'));
    }
}