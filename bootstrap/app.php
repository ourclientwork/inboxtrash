<?php

use App\Http\Middleware\ApiMiddleware;
use App\Http\Middleware\CanRegisterUser;
use App\Http\Middleware\CheckBanned;
use App\Http\Middleware\CheckBlogEnabled;
use App\Http\Middleware\CheckEmailVerification;
use App\Http\Middleware\CheckMaintenanceMode;
use App\Http\Middleware\CheckUserSubscription;
use App\Http\Middleware\IsAdmin;
use App\Http\Middleware\IsDemo;
use App\Http\Middleware\PreventAccessIfInstalled;
use App\Http\Middleware\RedirectIfAuthenticated;
use App\Http\Middleware\RedirectIfNotInstalled;
use App\Http\Middleware\Trustip;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Mcamara\LaravelLocalization\Middleware\LaravelLocalizationRedirectFilter;
use Mcamara\LaravelLocalization\Middleware\LaravelLocalizationRoutes;
use Mcamara\LaravelLocalization\Middleware\LaravelLocalizationViewPath;
use Mcamara\LaravelLocalization\Middleware\LocaleCookieRedirect;
use Mcamara\LaravelLocalization\Middleware\LocaleSessionRedirect;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        commands: __DIR__ . '/../routes/console.php',
        then: function () {
            Route::middleware('web')
                ->namespace('App\Http\Controllers')
                ->prefix(env('APP_DIR', ''))
                ->group(base_path('routes/web.php'));

            Route::middleware('api')
                ->namespace('App\Http\Controllers')
                ->prefix(env('APP_DIR') . '/api')
                ->group(base_path('routes/api.php'));
        },

    )
    ->withMiddleware(function (Middleware $middleware) {

        $middleware->alias([
            'admin' => IsAdmin::class,
            'verified' => CheckEmailVerification::class,
            'prevent-installed-access' => PreventAccessIfInstalled::class,
            'not-installed' => RedirectIfNotInstalled::class,
            'checkRegister' => CanRegisterUser::class,
            'checkBan' => CheckBanned::class,
            'localize' => LaravelLocalizationRoutes::class,
            'localizationRedirect' => LaravelLocalizationRedirectFilter::class,
            'localeSessionRedirect' => LocaleSessionRedirect::class,
            'localeCookieRedirect' => LocaleCookieRedirect::class,
            'localeViewPath' => LaravelLocalizationViewPath::class,
            'trustip' => Trustip::class,
            'blog.enabled' => CheckBlogEnabled::class,
            'api.enabled' => ApiMiddleware::class,
            'demo' => IsDemo::class,
            'guest' => RedirectIfAuthenticated::class,
            'maintenance' => CheckMaintenanceMode::class,
            'check.subscription' => CheckUserSubscription::class,
        ]);


        $middleware->redirectGuestsTo(function (Request $request) {
            $guard = 'web'; // default guard

            // Determine the guard based on the route prefix or other logic
            if ($request->is(env('ADMIN_PATH') . '/*') or $request->is(env('ADMIN_PATH'))) {
                $guard = 'admin';
            }

            // Redirect based on the guard
            switch ($guard) {
                case 'admin':
                    return route('admin.login');
                default:
                    return route('login');
            }
        });


        $middleware->validateCsrfTokens(except: [
            'get_messages',


            'webhooks/*'
        ]);

        $middleware->group('mcamara', [
            'localeCookieRedirect',
            'localizationRedirect',
            'localeViewPath',
        ]);

        $middleware->validateCsrfTokens(except: [
            'delete',

        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
