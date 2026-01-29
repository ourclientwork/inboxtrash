<?php

namespace App\Http\Controllers\Admin;

use App\Models\Coupon;
use Illuminate\Support\Str;
use Lobage\Planify\Models\Plan;
use App\Http\Controllers\Controller;
use App\Services\CouponFilterService;
use App\Http\Requests\Filter\FilterRequest;
use App\Http\Requests\Admin\StoreCouponRequest;
use App\Http\Requests\Admin\UpdateCouponRequest;

class CouponController extends Controller
{


    protected $filterService;

    public function __construct(CouponFilterService $filterService)
    {
        $this->filterService = $filterService;
    }



    public function index(FilterRequest $request)
    {
        $coupons = $this->filterService->filterCoupons($request);

        return view('admin.coupons.index')->with('coupons', $coupons);
    }



    public function create()
    {
        return view('admin.coupons.create')->with('plans', Plan::all())->with('code', strtoupper(Str::random(9)));
    }


    public function store(StoreCouponRequest $request)
    {

        if ($request->type == 1 &&  $request->amount > 100) {
            showToastr(__('The percentage cannot be greater than 100%'), 'error');
            return back();
        }

        $coupon = new Coupon();
        $coupon->code = $request->code;
        $coupon->limit = $request->limit;
        $coupon->name = $request->name;
        $coupon->type = $request->type;
        $coupon->value = $request->amount;
        $coupon->expired_at = $request->expiry_date;


        if ($request->has('applies_to_all')) {
            $coupon->applies_to_all = 1;
            $coupon->save();
        } else {
            $coupon->applies_to_all = 0;
            $coupon->save();
            $coupon->plans()->attach($request->plans);
        }


        showToastr(__('lobage.toastr.success'));
        return redirect(route('admin.coupons.index'));
    }


    public function edit(Coupon $coupon)
    {
        $arr = $coupon->plans->pluck('id')->toArray();

        return view('admin.coupons.edit')->with('coupon', $coupon)->with('arr', $arr)->with('plans', Plan::all());
    }


    public function update(UpdateCouponRequest $request, Coupon $coupon)
    {

        if ($request->type == 1 &&  $request->amount > 100) {
            showToastr(__('The percentage cannot be greater than 100%'), 'error');
            return back();
        }

        if ($coupon->limit != $request->limit) {
            $coupon->update([$coupon->usage = 0]);
        }

        $coupon->update([
            $coupon->code = $request->code,
            $coupon->limit = $request->limit,
            $coupon->name = $request->name,
            $coupon->type = $request->type,
            $coupon->value = $request->amount,
            $coupon->expired_at = $request->expiry_date,
        ]);


        if ($request->has('applies_to_all')) {
            $coupon->update([$coupon->applies_to_all = 1]);
            $coupon->plans()->sync([]);
        } else {
            $coupon->update([$coupon->applies_to_all = 0]);
            $coupon->plans()->sync($request->plans);
        }

        showToastr(__('lobage.toastr.update'));
        return redirect(route('admin.coupons.index'));
    }


    public function destroy(Coupon $coupon)
    {
        $coupon->delete();
        $coupon->plans()->detach();
        showToastr(__('lobage.toastr.delete'));
        return back();
    }
}
