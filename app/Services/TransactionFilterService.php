<?php

namespace App\Services;

use App\Models\Tax;
use App\Models\Transaction;
use Illuminate\Http\Request;

class TransactionFilterService
{

    public function filterTransactions(Request $request)
    {
        $query = Transaction::with('user'); // eager load user for name/email filtering

        // Search query
        if ($request->has('q') && $search = $request->input('q')) {
            $query->where(function ($q) use ($search) {
                $q->whereHas('user', function ($uq) use ($search) {
                    $uq->where('email', 'like', "%{$search}%")
                        ->orWhere('firstname', 'like', "%{$search}%")
                        ->orWhere('lastname', 'like', "%{$search}%");
                })
                    ->orWhere('transaction_id', 'like', "%{$search}%")
                    ->orWhere('payment_id', 'like', "%{$search}%")
                    ->orWhere('payer_id', 'like', "%{$search}%")
                    ->orWhere('gateway', 'like', "%{$search}%")
                    ->orWhere('coupon_code', 'like', "%{$search}%");
            });
        }


        if ($request->has('user')) {
            $query->where('user_id', $request->input('user'));
        }


        if ($request->has('status') && $request->input('status') != "all") {
            $query->where('status', $request->input('status'));
        }


        $orderBy = $request->input('order_by', 'created_at');
        $orderType = $request->input('order_type', 'desc');
        $limit = $request->input('limit', 25);

        return $query->orderBy($orderBy, $orderType)->paginate($limit);
    }
}