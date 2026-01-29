<?php

namespace App\Services;

use GuzzleHttp\Client;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use GuzzleHttp\Exception\RequestException;

class InstallService
{
    public function checkRequirements()
    {

        // Logic to check server requirements
        return [

            'php_version' => version_compare(PHP_VERSION, '8.2', '>='),
            'extensions' => [
                'Mbstring' => extension_loaded('mbstring'),
                'BCMath' => extension_loaded('bcmath'),
                'Ctype' => extension_loaded('ctype'),
                'Json' => extension_loaded('json'),
                'OpenSSL' => extension_loaded('openssl'),
                'PDO' => extension_loaded('pdo'),
                'Tokenizer' => extension_loaded('tokenizer'),
                'XML' => extension_loaded('xml'),
                'Fileinfo' => extension_loaded('fileinfo'),
                'Fopen' => ini_get('allow_url_fopen'),
                'IMAP' => extension_loaded('imap'),
                'Iconv' => extension_loaded('iconv'),
                'Zip' => extension_loaded('zip'),
                'cURL' => extension_loaded('curl'),
                'GD' => extension_loaded('gd'),
                // Add more requirements as needed

            ],
        ];
    }



    public function checkFilePermissions()
    {
        // Logic to check file permissions
        return [
            'storage' => is_writable(base_path('storage/')),
            'bootstrap/' => is_writable(base_path('bootstrap/')),
            'bootstrap/cache' => is_writable(base_path('bootstrap/cache')),
            'public/' => is_writable(base_path('public/')),
            // Add more file permission checks as needed
        ];
    }

    public function checkLicense($key, $id = null)
    {
        $id = $id ?? config('lobage.id');

        $params = [
            'purchase_code' => $key,
            'url' => url('/'),
            'id' => $id,
        ];

        $endpoints = [
            config('lobage.api'),
            config('lobage.api_v2'),
        ];

        foreach ($endpoints as $baseUri) {
            try {
                $client = new Client([
                    'base_uri' => $baseUri,
                    'timeout' => 15,
                ]);

                $response = $client->post('install', [
                    'query' => $params
                ]);

                $sale = json_decode($response->getBody(), true);

                if (!is_null($sale)) {
                    return $sale;
                }

                throw new \Exception("Empty response from API");
            } catch (RequestException $e) {
                Log::warning("API request failed at {$baseUri}: {$e->getMessage()}");

                if ($e->hasResponse()) {
                    return json_decode($e->getResponse()->getBody()->getContents(), true);
                }

                // If no response, try the next endpoint
            } catch (\Throwable $e) {
                Log::error("Unexpected error at {$baseUri}: {$e->getMessage()}");
            }
        }

        return null;
    }

    public function importDatabase()
    {
        return true;
    }
}
