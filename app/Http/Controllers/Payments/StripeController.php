<?php

namespace App\Http\Controllers\Payments;

use Exception;
use Stripe\Stripe;
use App\Models\Transaction;
use Illuminate\Http\Request;
use UnexpectedValueException;
use App\Http\Controllers\Controller;

class StripeController extends Controller
{
    private $stripe_secret;
    private $endpoint_secret;
    public $currency;
    public $brand;
    public $brand_img;


    public function __construct()
    {
        $stripe = plugin('stripe');
        $this->stripe_secret = $stripe->secret->value ?? null;
        $this->endpoint_secret = $stripe->endpoint_secret->value ?? null;
        $this->currency = getSetting('currency_code');
        $this->brand = getSetting('site_name');
        $this->brand_img = asset(getSetting('logo'));
    }

    public function pay($trx)
    {

        if (!isPluginEnabled('stripe')) {
            return [
                'success' => false,
                'message' => 'This payment method is currently unavailable.',
                'process_data' => ""
            ];
        }

        try {
            \Stripe\Stripe::setApiKey($this->stripe_secret);
            $session = \Stripe\Checkout\Session::create([
                'payment_method_types' => ['card'],
                'line_items' => [[
                    'price_data' => [
                        'currency' => $this->currency,
                        'product_data' => [
                            'name' => $trx->plan->name,
                        ],
                        'unit_amount' => intval($trx->amount * 100), // Stripe expects amount in cents
                    ],
                    'quantity' => 1
                ]],
                'customer_creation' => 'always',
                'customer_email' => $trx->user->email,
                'mode' => 'payment',
                'success_url' => route('verify-payment', 'stripe') . '?session_id={CHECKOUT_SESSION_ID}',
                'cancel_url' => route('verify-payment', 'stripe'),
                'metadata' => [
                    'trx_id' => $trx->id,
                ],
            ]);

            return [
                'success' => true,
                'payment_id' => $session->id,
                'html' => "",
                'redirect_url' => $session->url
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => "An error occurred while executing the operation",
                'process_data' => $e->getMessage()
            ];
        }
    }


    public function verify(Request $request): array
    {
        $session_id = $request->get('session_id');
        $stripe = new \Stripe\StripeClient($this->stripe_secret);

        try {
            $session = $stripe->checkout->sessions->retrieve($session_id);

            if ($session->payment_status === 'paid') {
                return [
                    'success' => true,
                    'payment_id' => $session->id,
                    'message' => "operation completed successfully",
                    'process_data' => $session,
                ];
            } else {
                return [
                    'success' => false,
                    'payment_id' => $session->id,
                    'message' => "Payment not completed",
                    'process_data' => $session,
                ];
            }
        } catch (\Exception $e) {
            return [
                'success' => false,
                'payment_id' => $session_id,
                'message' => "An error occurred while executing the operation",
                'process_data' => $e->getMessage(),
            ];
        }
    }



    public function verifyWebhook(Request $request)
    {
        $payload = $request->getContent();
        $sig_header = $request->header('Stripe-Signature');
        $webhookSecret = $this->endpoint_secret;

        try {
            $event = \Stripe\Webhook::constructEvent(
                $payload,
                $sig_header,
                $webhookSecret
            );
        } catch (\UnexpectedValueException $e) {
            // Invalid payload
            return [
                'success' => false,
                'message' => 'Invalid payload',
                'process_data' => $e->getMessage(),
            ];
        } catch (\Stripe\Exception\SignatureVerificationException $e) {
            // Invalid signature
            return [
                'success' => false,
                'message' => 'Invalid signature',
                'process_data' => $e->getMessage(),
            ];
        }


        $data = $event->data->object;

        if ($event->type === 'checkout.session.completed' && $data->payment_status === 'paid') {
            $payment_id = $data->id;
            $payer_id = $data->customer ?? null;

            $trx = Transaction::where('payment_id', $payment_id)->whereIn('status', [0, 2])->first();
            if ($trx) {

                $trx->update([
                    'status' => 1,
                    'paid_at' => now(),
                    'payer_id' => $payer_id,
                ]);
                return [
                    'success' => true,
                    'payment_id' => $payment_id,
                    'message' => "operation completed successfully",
                    'process_data' => $trx,
                ];
            }
        }

        return [
            'success' => false,
            'message' => "No matching event or transaction",
            'process_data' => $event,
        ];
    }
}