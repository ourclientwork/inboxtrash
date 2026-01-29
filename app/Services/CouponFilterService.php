<?php

namespace App\Services;

use App\Models\Coupon;
use Illuminate\Http\Request;

class CouponFilterService
{
    public function filterCoupons(Request $request)
    {
        $query = Coupon::query();

        if ($request->has('q')) {
            $query->where('name', 'like', '%' . $request->input('q') . '%')
                ->orWhere('code', 'like', '%' . $request->input('q') . '%');
        }



        $orderBy = $request->input('order_by') ?? 'created_at';
        $orderType = $request->input('order_type') ?? 'desc';
        $query->orderBy($orderBy, $orderType);
        $limit = $request->input('limit', 25); // Default to 15 items per page if not specified

        return $query->paginate($limit);
    }
}
