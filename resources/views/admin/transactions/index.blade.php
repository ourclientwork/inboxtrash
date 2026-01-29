@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Transactions' />


    <div class="box p-3">
        <div class="table-header mb-3">
            <div class="row row-cols-auto flex-row-reverse align-items-center  g-2">
                <div class="col">
                    <div class="drop-down drop-down-md filters" data-dropdown="" data-dropdown-propagation="">
                        <div class="drop-down-btn btn btn-theme btn-md cp-x-2">
                            <i class="fa-solid fa-filter"></i>
                        </div>
                        <!-- Dropdown Menu -->
                        <div class="drop-down-menu">
                            <div class="filters-box">
                                <div class="filters-box-header d-flex justify-content-between gap-2">
                                    <p class="filters-box-title mb-0">
                                        {{ __('Filters') }}
                                    </p>
                                    <a href="{{ route('admin.transactions.index') }}"
                                        class="filters-box-reset btn btn-reset">
                                        <i class="fa fa-times"></i>
                                        <span>{{ __('Reset') }}</span>
                                    </a>
                                </div>
                                <form method="GET" action="{{ route('admin.transactions.index') }}">
                                    @if (request('lang'))
                                        <input type="hidden" name="lang" value="{{ request('lang') }}">
                                    @endif
                                    <div class="filters-box-body">
                                        <div class="filters-box-items">
                                            <h6 class="mb-3">{{ __('Search') }}</h6>
                                            <div class="col">
                                                <input type="text" name="q" class="form-control "
                                                    placeholder="Type your query here..." value="{{ request('q') }}">
                                            </div>
                                        </div>
                                        <div class="filters-box-items">
                                            <h6 class="mb-3">{{ __('Status') }}</h6>
                                            <div class="col">
                                                <select name="status" class="form-select ">
                                                    <option value="all"
                                                        {{ request('status') == 'all' ? 'selected' : '' }}>
                                                        {{ __('All') }}
                                                    </option>
                                                    <option value="2"
                                                        {{ request('status') == '2' ? 'selected' : '' }}>
                                                        {{ __('Pending') }}
                                                    </option>
                                                    <option value="1"
                                                        {{ request('status') == '1' ? 'selected' : '' }}>
                                                        {{ __('Completed') }}
                                                    </option>
                                                    <option value="3"
                                                        {{ request('status') == '3' ? 'selected' : '' }}>
                                                        {{ __('Canceled') }}
                                                    </option>
                                                    <option value="0"
                                                        {{ request('status') == '0' ? 'selected' : '' }}>
                                                        {{ __('Unpaid') }}
                                                    </option>
                                                    <option value="4"
                                                        {{ request('status') == '4' ? 'selected' : '' }}>
                                                        {{ __('Refunded') }}
                                                    </option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="filters-box-items">
                                            <h6 class="mb-3">{{ __('Order by') }}</h6>
                                            <div class="col">
                                                <select name="order_by" class="form-select ">
                                                    <option value="created_at"
                                                        {{ request('order_by') == 'created_at' ? 'selected' : '' }}>
                                                        {{ __('Date') }}
                                                    </option>
                                                    <option value="amount"
                                                        {{ request('order_by') == 'amount' ? 'selected' : '' }}>
                                                        {{ __('Price') }}
                                                    </option>
                                                    <!-- Add more options as needed -->
                                                </select>
                                            </div>
                                        </div>

                                        <div class="filters-box-items">
                                            <h6 class="mb-3">{{ __('Order type') }}</h6>
                                            <div class="col">
                                                <select name="order_type" class="form-select ">
                                                    <option value="desc"
                                                        {{ request('order_type') == 'desc' ? 'selected' : '' }}>
                                                        {{ __('Descending') }}
                                                    </option>
                                                    <option value="asc"
                                                        {{ request('order_type') == 'asc' ? 'selected' : '' }}>
                                                        {{ __('Ascending') }}
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="filters-box-items">
                                            <h6 class="mb-3">{{ __('Results per page') }}</h6>
                                            <div class="col">
                                                <select name="limit" class="form-select">
                                                    <option value="25" {{ request('limit') == 25 ? 'selected' : '' }}>
                                                        25
                                                    </option>
                                                    <option value="50" {{ request('limit') == 50 ? 'selected' : '' }}>
                                                        50
                                                    </option>
                                                    <option value="100" {{ request('limit') == 100 ? 'selected' : '' }}>
                                                        100
                                                    </option>
                                                    <option value="250" {{ request('limit') == 250 ? 'selected' : '' }}>
                                                        250
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="filters-box-header d-flex justify-content-end gap-2">
                                            <button type="reset" class="btn btn-outline-danger w-50"
                                                data-dropdown-close="">{{ __('Cancel') }}</button>
                                            <button type="submit"
                                                class="btn btn-primary w-50">{{ __('Apply') }}</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- /Dropdown Menu -->
                    </div>
                </div>
            </div>
        </div>

        <div class="table-inner">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="text-center">{{ __('Transaction ID') }}</th>
                            <th class="text-center">{{ __('User') }}</th>
                            <th class="text-center">{{ __('Plan Name') }}</th>
                            <th class="text-center">{{ __('Amount') }}</th>
                            <th class="text-center">{{ __('Gateway') }}</th>
                            <th class="text-center">{{ __('Status') }}</th>
                            <th class="text-center">{{ __('Created') }}</th>
                            <th class="text-center">{{ __('Actions') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse  ($transactions as $transaction)
                            <tr>
                                <td class="text-center">
                                    <a href="{{ route('admin.transactions.show', $transaction->id) }}">
                                        {{ $transaction->transaction_id }}
                                    </a>
                                </td>
                                <td class="text-center">
                                    <a href="{{ route('admin.users.edit', $transaction->user_id) }}">
                                        {{ $transaction->user->getFullName() }}
                                    </a>
                                </td>
                                <td class="text-center">
                                    <span class="badge {{ $transaction->getPlansColor() }}">
                                        {{ $transaction->plan->name }}
                                    </span>
                                </td>
                                <td class="text-center">
                                    {{ $transaction->amount . ' ' . $transaction->currency }}
                                </td>

                                <td class="text-center">
                                    <span class="badge {{ $transaction->getGatewaysColor() }}">
                                        {{ ucfirst($transaction->gateway) }}
                                    </span>
                                </td>

                                <td class="text-center">
                                    <span class="badge {{ $transaction->getStatusColor() }}">
                                        {{ $transaction->getStatusName() }}
                                    </span>
                                </td>
                                <td class="text-center">
                                    {{ toDate($transaction->created_at) }}
                                </td>
                                <td class="d-flex justify-content-center">
                                    <div class="d-flex gap-2">
                                        <a href="{{ route('admin.transactions.show', $transaction->id) }}"
                                            class="btn btn-primary cp-x-2">
                                            <i class="far fa-eye"></i>
                                        </a>
                                        <button class="btn btn-danger cp-x-2" data-bs-toggle="modal"
                                            data-bs-target="#deleteModal" data-id="{{ $transaction->id }}"
                                            data-action="{{ route('admin.transactions.destroy', $transaction->id) }}">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <x-empty title="transactions" />
                        @endforelse

                    </tbody>
                </table>
            </div>
        </div>
        <div class="table-footer mt-3">
            <div class="row row-cols-auto justify-content-between align-items-center g-3">
                <div class="col">
                    <span>
                        {{ __('Showing') }} {{ $transactions->firstItem() }} {{ __('to') }}
                        {{ $transactions->lastItem() }} {{ __('of') }}
                        {{ $transactions->total() }} {{ __('entries') }}
                    </span>
                </div>
                <div class="col">
                    {{ $transactions->appends(request()->query())->links() }}
                </div>
            </div>
        </div>
    </div>
    <x-delete-modal />
@endsection
