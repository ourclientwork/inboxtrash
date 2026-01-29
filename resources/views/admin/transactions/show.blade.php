@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Transaction #{{ $transaction->transaction_id }}' BackTo="{{ route('admin.transactions.index') }}">

    </x-breadcrumb>
    <div>
        <div class="row gx-4 gy-4">

            {{-- Transaction Details --}}
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-primary text-white">
                        {{ __('Transaction Details') }}
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Payment ID') }}</strong></span>
                            <span>{{ $transaction->payment_id }}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Payer ID') }}</strong></span>
                            <span>{{ $transaction->payer_id ?? 'None' }}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('User') }}</strong></span>
                            <span><a href="{{ route('admin.users.edit', $transaction->user_id) }}">
                                    {{ $transaction->user->getFullName() }}
                                </a></span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Plan') }}</strong></span>
                            <span><a
                                    href="{{ route('admin.plans.edit', $transaction->plan_id) }}">{{ $transaction->plan->name }}</a></span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Interval') }}</strong></span>
                            <span>{{ ucfirst($transaction->interval) }}</span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Status') }}</strong></span>
                            <span class="badge {{ $transaction->getStatusColor() }}">
                                {{ $transaction->getStatusName() }}
                            </span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Gateway') }}</strong></span>
                            <span class="badge {{ $transaction->getGatewaysColor() }}">
                                {{ ucfirst($transaction->gateway) }}
                            </span>
                        </li>

                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Created at') }}</strong></span>
                            <span>{{ toDate($transaction->created_at) }}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Paid at') }}</strong></span>
                            <span>{{ toDate($transaction->paid_at) }}</span>
                        </li>
                    </ul>
                </div>
            </div>

            {{-- Payment Summary --}}
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-secondary text-white">
                        {{ __('Payment Summary') }}
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Plan Price') }}</strong></span>
                            <span>{{ $transaction->plan_price . ' ' . $transaction->currency }}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Taxes') }}
                                </strong>{{ $transaction->tax_name ? "($transaction->tax_name $transaction->tax_rate%)" : '' }}</span>
                            <span>{{ $transaction->tax_amount . ' ' . $transaction->currency }}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between p-3">
                            <span><strong>{{ __('Coupon') }}
                                </strong>{{ $transaction->coupon_code ? "($transaction->coupon_code)" : '' }}</span>
                            <span>-{{ $transaction->discount_amount . ' ' . $transaction->currency }}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between bg-light fw-bold p-3">
                            <span><strong>{{ __('Total') }}</strong></span>
                            <span>{{ $transaction->amount . ' ' . $transaction->currency }}</span>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </div>
@endsection
