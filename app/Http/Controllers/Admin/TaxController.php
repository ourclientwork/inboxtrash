<?php

namespace App\Http\Controllers\Admin;

use App\Models\Tax;
use App\Services\TaxFilterService;
use App\Http\Controllers\Controller;
use App\Http\Requests\Filter\FilterRequest;
use App\Http\Requests\Admin\StoreTaxRequest;
use App\Http\Requests\Admin\UpdateTaxRequest;

class TaxController extends Controller
{


    protected $filterService;

    public function __construct(TaxFilterService $filterService)
    {
        $this->filterService = $filterService;
    }

    public function index(FilterRequest $request)
    {
        $taxes = $this->filterService->filterTaxes($request);

        return view('admin.taxes.index')->with('taxes', $taxes);
    }


    public function create()
    {
        $taxCodes = Tax::pluck('country')->toArray();
        return view('admin.taxes.create')->with("taxcodes", $taxCodes);
    }


    public function store(StoreTaxRequest $request)
    {
        Tax::create($request->validated());
        showToastr(__('lobage.toastr.success'));
        return redirect(route('admin.taxes.index'));
    }

    public function edit(Tax $tax)
    {
        $taxCodes = Tax::where('id', '!=', $tax->id)->pluck('country')->toArray();
        return view('admin.taxes.edit')->with('tax', $tax)->with('taxcodes', $taxCodes);
    }

    public function update(UpdateTaxRequest $request, Tax $tax)
    {
        $tax->update($request->validated());
        showToastr(__('lobage.toastr.update'));
        return redirect(route('admin.taxes.index'));
    }

    public function destroy(Tax $tax)
    {
        $tax->delete();
        showToastr(__('lobage.toastr.delete'));
        return back();
    }
}
