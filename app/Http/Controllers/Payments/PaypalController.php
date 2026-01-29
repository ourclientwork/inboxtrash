<?php

namespace App\Http\Controllers\Payments;


use Exception;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use PayPalCheckoutSdk\Core\PayPalHttpClient;
use PayPalCheckoutSdk\Core\SandboxEnvironment;
use PayPalCheckoutSdk\Core\ProductionEnvironment;
use PayPalCheckoutSdk\Orders\OrdersCreateRequest;
use PayPalCheckoutSdk\Orders\OrdersCaptureRequest;

class PaypalController extends Controller
{
    private $paypal_client_id;
    private $paypal_secret;
    public $paypal_mode;
    public $currency;
    public $webhookId;

    public function __construct()
    {
        $paypal = plugin('paypal');
        $this->paypal_client_id = $paypal->client_id->value ?? null;
        $this->paypal_secret = $paypal->secret->value ?? null;
        $this->paypal_mode = $paypal->mode->value ?? null;
        $this->webhookId = $paypal->webhookId->value ?? null;
        $this->currency = getSetting('currency_code');
    }

    public function pay($trx)
    {

        if (!isPluginEnabled('paypal')) {
            return [
                'success' => false,
                'message' => 'This payment method is currently unavailable.',
                'process_data' => ""
            ];
        }

        if (!in_array($this->currency, $this->supported_currency_list())) {
            return [
                'success' => false,
                'message' => 'The selected currency is not supported for this payment method.',
                'process_data' => ""
            ];
        }

        if ($this->paypal_mode == "live")
            $environment = new ProductionEnvironment($this->paypal_client_id, $this->paypal_secret);
        else
            $environment = new SandboxEnvironment($this->paypal_client_id, $this->paypal_secret);


        $client = new PayPalHttpClient($environment);

        $request = new OrdersCreateRequest();
        $request->prefer('return=representation');


        $unitAmount = $trx->plan->price;
        $taxAmount = $trx->tax_amount;
        $couponDiscount = $trx->discount_amount;
        $handlingFee = 0;

        //$itemTotal = $unitAmount * $quantity;
        $itemTotal = $unitAmount + $handlingFee + $taxAmount - $couponDiscount;


        $request->body = [
            "intent" => "CAPTURE",
            "purchase_units" => [[
                "reference_id" => $trx->id,
                "custom_id" => "TRX-" . $trx->id,
                "description" => "paypal",
                "amount" => [
                    "value" => number_format($itemTotal, 2, '.', ''),
                    "currency_code" => $this->currency,
                    "breakdown" => [
                        "item_total" => [
                            "value" => number_format($unitAmount, 2, '.', ''),
                            "currency_code" => $this->currency,
                        ],
                        "tax_total" => [
                            "value" => number_format($taxAmount, 2, '.', ''),
                            "currency_code" => $this->currency,
                        ],
                        "handling" => [
                            "value" => number_format($handlingFee, 2, '.', ''),
                            "currency_code" => $this->currency,
                        ],
                        "discount" => [
                            "value" => number_format($couponDiscount, 2, '.', ''),
                            "currency_code" => $this->currency,
                        ],
                    ],
                ],
                "items" => [[
                    "name" => $trx->plan->name,
                    "description" => $trx->plan->is_lifetime ? 'lifetime' : "1 " . $trx->plan->invoice_interval . " subscription",
                    "quantity" => 1,
                    "unit_amount" => [
                        "currency_code" => $this->currency,
                        "value" => number_format($unitAmount, 2, '.', ''),
                    ],
                    "tax" => [
                        "currency_code" => $this->currency,
                        "value" => number_format($taxAmount, 2, '.', ''),
                    ]
                ]]
            ]],
            "application_context" => [
                "brand_name" => getSetting('site_name'),
                "landing_page" => "NO_PREFERENCE",
                "shipping_preference" => "NO_SHIPPING",
                "user_action" => "PAY_NOW",
                "cancel_url" => route('verify-payment', 'paypal'),
                "return_url" => route('verify-payment', 'paypal'),
            ]
        ];

        try {
            $response = json_decode(json_encode($client->execute($request)), true);
            $data =  [
                'success' => true,
                'payment_id' => $response['result']['id'],
                'html' => "",
                'redirect_url' => collect($response['result']['links'])->where('rel', 'approve')->firstOrFail()['href']
            ];

            return $data;
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => "An error occurred while executing the operation",
                'process_data' => $e
            ];
        }
    }


    public function verifyWebhook(Request $request)
    {
        $payload = $request->getContent();
        $headers = $request->headers->all();

        // Validate the webhook (optional but recommended)
        try {
            if (!$this->verifySignature($headers, $payload)) {
                //Log::warning('Invalid PayPal Webhook signature');
                return [
                    'success' => false,
                    'message' => "invalid signature",
                    'process_data' => null
                ];
            }

            $data = json_decode($payload, true);


            if (!$data) {
                return [
                    'success' => false,
                    'message' => "Invalid data",
                    'process_data' => $data
                ];
            }

            if (isset($data['event_type']) && $data['event_type'] === 'PAYMENT.CAPTURE.COMPLETED') {
                if (isset($data['resource']['status']) && $data['resource']['status'] === 'COMPLETED') {
                    $supplementaryData = $data['resource']['supplementary_data'];
                    $payment_id = $supplementaryData['related_ids']['order_id'];
                    $payer_id =  $data['resource']['payee']['merchant_id'];
                    $trx = Transaction::where('payment_id', $payment_id)->whereIn("status", [0, 2])->first();
                    if ($trx) {

                        $trx->update(['status' => 1, 'paid_at' => now(), 'payer_id' => $payer_id]);
                        return [
                            'success' => true,
                            'payment_id' => $payment_id,
                            'message' => "operation completed successfully",
                            'process_data' => $trx
                        ];
                    }
                }
            }

            return [
                'success' => false,
                'message' => "An error occurred while executing the operation",
                'process_data' => $data
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'message' => "An error occurred while executing the operation",
                'process_data' => $e
            ];
        }
    }


    public function verify(Request $request): array
    {

        if ($this->paypal_mode == "live")
            $environment = new ProductionEnvironment($this->paypal_client_id, $this->paypal_secret);
        else
            $environment = new SandboxEnvironment($this->paypal_client_id, $this->paypal_secret);

        $client = new PayPalHttpClient($environment);

        try {
            $response = $client->execute(new OrdersCaptureRequest($request['token']));
            $result = json_decode(json_encode($response), true);
            if ($result['result']['status'] == "COMPLETED" && $result['statusCode'] == 201) {
                return [
                    'success' => true,
                    'payment_id' => $request['token'],
                    'message' => "operation completed successfully",
                    'process_data' => $result
                ];
            } else {
                return [
                    'success' => false,
                    'payment_id' => $request['token'],
                    'message' => "An error occurred while executing the operation",
                    'process_data' => $result
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'payment_id' => $request['token'],
                'message' => "An error occurred while executing the operation",
                'process_data' => $e
            ];
        }
    }


    protected function verifySignature(array $headers, string $payload): bool
    {
        $webhookId = $this->webhookId;

        $transmissionId = $headers['paypal-transmission-id'][0] ?? null;
        $timeStamp      = $headers['paypal-transmission-time'][0] ?? null;
        $signature      = $headers['paypal-transmission-sig'][0] ?? null;
        $certUrl        = $headers['paypal-cert-url'][0] ?? null;

        if (!$transmissionId || !$timeStamp || !$signature || !$certUrl) {
            // missing required headers
            return false;
        }

        // Ensure the cert URL is HTTPS to avoid MITM attacks
        if (!str_starts_with($certUrl, 'https://')) {
            return false;
        }

        $crc32Checksum = crc32($payload);

        $input = implode('|', [
            $transmissionId,
            $timeStamp,
            $webhookId,
            $crc32Checksum,
        ]);

        $certContent = @file_get_contents($certUrl);

        if (!$certContent) {
            // unable to fetch certificate
            return false;
        }

        $publicKey = openssl_pkey_get_public($certContent);

        if (!$publicKey) {
            return false;
        }

        $isVerified = openssl_verify(
            $input,
            base64_decode($signature),
            $publicKey,
            OPENSSL_ALGO_SHA256
        );

        openssl_free_key($publicKey);

        return $isVerified === 1;
    }


    public function supported_currency_list()
    {
        return ['AUD', 'BRL', 'CAD', 'CNY', 'CZK', 'DKK', 'EUR', 'HKD', 'HUF', 'ILS', 'JPY', 'MYR', 'MXN', 'TWD', 'NZD', 'NOK', 'PHP', 'PLN', 'GBP', 'SGD', 'SEK', 'CHF', 'THB', 'USD'];
    }
}