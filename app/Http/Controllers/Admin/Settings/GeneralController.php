<?php

namespace App\Http\Controllers\Admin\Settings;

use App\Models\Seo;
use App\Models\Setting;
use Illuminate\Http\Request;
use Lobage\Planify\Models\Plan;
use App\Http\Controllers\Controller;



class GeneralController extends Controller
{
    public function index()
    {
        $plans = Plan::where('trial_period', '!=', 0)
            ->where('tag', '!=', 'guest')
            ->orWhere('tag',  'free')
            ->orderBy('id', 'asc')
            ->get();

        return view('admin.settings.general')->with('plans', $plans);
    }

    public function update(Request $request)
    {
        $request->validate([
            'site_name' => 'required|max:255',
            'site_url' => 'required|url',
            'default_language' => 'required|in:' . getAllLanguagesValidation(),
            'timezone' => 'required',
            'privacy_policy' => 'required|url',
            'terms_of_service' => 'required|url',
            'cookie_policy' => 'required|url',
            'call_to_action' => 'required|url',
            'currency_code' => 'required|max:3',
            'currency_symbol' => 'required',
            'user_plan_expiry_reminder' => 'required|integer',
            'auto_delete_unverified_users' => 'required|integer',
        ]);

        $check = Seo::where('lang', $request->default_language)->first();

        if (!$check) {
            showToastr(__('You must add the SEO for the language before changing it'), 'error');
            return redirect(route('admin.settings.seo.index'));
        }

        $request->site_url = rtrim($request->site_url, '/');

        $settings = Setting::whereIn(
            'key',
            [
                'site_name',
                'site_url',
                'default_language',
                'timezone',
                'privacy_policy',
                'site_url',
                'terms_of_service',
                'cookie_policy',
                'enable_preloader',
                'hide_default_lang',
                'enable_cookie',
                'https_force',
                'enable_verification',
                'enable_registration',
                'cookie_policy',
                'call_to_action',
                'currency_code',
                'currency_symbol',
                'user_plan_expiry_reminder',
                'auto_delete_unverified_users',
            ]
        )->get();


        foreach ($settings as $setting) {
            $key = $setting->key;
            setSetting($key, $request->$key);
        }

        updateEnvFile('APP_NAME', $request->site_name);
        updateEnvFile('APP_URL', $request->site_url);
        updateEnvFile('APP_TIMEZONE', $request->timezone);
        updateEnvFile('DEFAULT_LANG', $request->default_language);

        updateEnvFile('HIDE_DEFAULT_LANG_IN_URL', $request->hide_default_lang ? "true" : "false");
        updateEnvFile('HTTPS_FORCE', $request->https_force ? "true" : "false");

        showToastr(__('lobage.toastr.update'));
        return back();
    }
}
