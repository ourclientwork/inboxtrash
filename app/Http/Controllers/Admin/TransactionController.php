<?php

namespace App\Http\Controllers\Admin;

use App\Models\Transaction;
use App\Http\Controllers\Controller;
use App\Services\TransactionFilterService;
use App\Http\Requests\Filter\TransactionFilterRequest;


class TransactionController extends Controller
{

    protected $transactionService;

    public function __construct(TransactionFilterService $transactionService)
    {
        $this->transactionService = $transactionService;
    }

    public function index(TransactionFilterRequest $request)
    {
        $transactions = $this->transactionService->filterTransactions($request);

        $totalTransactions = Transaction::count();

        $totalEarnings = Transaction::where('status', 1)->sum('amount');

        $totalDiscounts = Transaction::sum('discount_amount');

        $totalTaxCollected = Transaction::sum('tax_amount');

        return view('admin.transactions.index', compact('transactions', 'totalTransactions', 'totalEarnings', 'totalTaxCollected', 'totalDiscounts'));
    }

    public function show(Transaction $transaction)
    {
        return view('admin.transactions.show', compact('transaction'));
    }
}
