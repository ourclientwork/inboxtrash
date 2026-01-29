<?php

namespace App\Services;

use App\Models\Tax;
use Illuminate\Http\Request;

class TaxFilterService
{
    public function filterTaxes(Request $request)
    {
        $query = Tax::query();

        if ($request->has('q')) {
            $query->where('name', 'like', '%' . $request->input('q') . '%');
        }

        $orderBy = $request->input('order_by') ?? 'created_at';
        $orderType = $request->input('order_type') ?? 'desc';
        $query->orderBy($orderBy, $orderType);
        $limit = $request->input('limit', 25); // Default to 15 items per page if not specified

        return $query->paginate($limit);
    }
}
