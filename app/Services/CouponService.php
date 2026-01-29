<?php

namespace App\Services;

use Carbon\Carbon;
use App\Models\Coupon;
use Illuminate\Validation\ValidationException;

class CouponService
{
    public function applyCoupon($discountCode, $plan, $usage = false)
    {

        $coupon = Coupon::where('code', $discountCode)->first();

        if (!$coupon) {
            throw ValidationException::withMessages([
                'discount' => [translate('Coupon code is invalid', 'alerts')],
            ]);
        }

        if (!$coupon->plans->contains($plan->id) && !$coupon->applies_to_all) {
            throw ValidationException::withMessages([
                'discount' => [translate('Coupon code is invalid', 'alerts')],
            ]);
        }

        $this->checkCouponLimits($coupon);

        $this->checkCouponExpiration($coupon);

        $discount = $this->calculateDiscount($coupon, $plan);

        if ($usage) {
            $coupon->update(["usage" => $coupon->usage + 1]);
        }

        return $discount;
    }

    protected function validateDiscountCode($discountCode)
    {
        if (empty($discountCode)) {
            throw ValidationException::withMessages([
                'discount' => [translate('Discount code is required', 'alerts')],
            ]);
        }
    }

    protected function checkCouponLimits($coupon)
    {

        if ($coupon->limit != "-1" && $coupon->limit <= $coupon->usage) {
            throw ValidationException::withMessages([
                'discount' => [translate('Coupon usage limit has been reached', 'alerts')],
            ]);
        }
    }

    protected function checkCouponExpiration($coupon)
    {
        if ($coupon->expired_at && Carbon::parse($coupon->expired_at)->isPast()) {
            throw ValidationException::withMessages([
                'discount' => [translate('The coupon has expired', 'alerts')],
            ]);
        }
    }

    protected function calculateDiscount($coupon, $plan)
    {
        if (!$coupon->type) {
            $discount = $plan->price >= $coupon->value ? number_format($coupon->value, 2) : $plan->price;
        } else {
            $discount = number_format($plan->price * $coupon->value / 100, 2);
        }

        return $discount;
    }
}
