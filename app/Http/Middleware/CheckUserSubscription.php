<?php

namespace App\Http\Middleware;

use Closure;
use Auth;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckUserSubscription
{

    protected $exceptRoutesFirstTime = [
        'settings',
        'plans',
        'checkout',
        'checkout.coupon',
        'checkout.pay',
        'verify-payment',
    ];


    protected $exceptRoutes = [
        'settings',
        'plans',
        'checkout',
        'checkout.coupon',
        'checkout.pay',
        'verify-payment',
        'domains.index',
        'domains.destroy',
        'messages.index',
        'messages.destroy',
    ];


    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {

        $user = Auth::user();

        if ($user && $user->subscriptions()->count() === 0) {

            if ($this->inExceptArray($request, $this->exceptRoutesFirstTime)) {
                return $next($request);
            }

            return redirect()->route('plans'); // assuming your route name is 'plans'
        }


        if ($user && !$user->subscription('main')->isActive()) {

            if ($this->inExceptArray($request, $this->exceptRoutes)) {
                return $next($request);
            }

            return redirect()->route('plans'); // assuming your route name is 'plans'

        }

        return $next($request);
    }

    protected function inExceptArray($request, $exceptRoutes)
    {
        foreach ($exceptRoutes as $route) {
            if ($request->routeIs($route)) {
                return true;
            }
        }
        return false;
    }
}
