@extends('frontend.user.layouts.app')

@section('content')
    <x-breadcrumb title='Billing' :nav="false">
        <div class="col-auto">

            @if (!$subscription->isLifetime() && $subscription->getSubscriptionPeriodRemainingUsageIn('day') < 3)
                <a href="{{ route('checkout', encode_hash($subscription->plan->id)) }}" class="btn btn-success h-100">
                    <i class="fa-solid fa-rotate"></i>
                    {{ $subscription->isOnTrial() ? translate('Subscribe Now') : translate('Renew') }}
                </a>
            @endif

            <a href="{{ route('plans') }}" class="btn btn-primary h-100">
                <i class="fa-solid fa-rocket"></i>
                {{ translate('Change Plan') }}
            </a>

        </div>
    </x-breadcrumb>
    <div class="row g-4">

        {{-- Plan Name --}}
        <div class="{{ $subscription->isLifetime() ? 'col-md-12' : 'col-md-6' }}">
            <div class="box h-100">
                <div class="counter">
                    <div class="counter-info">
                        <p class="counter-amount">{{ translate($subscription->plan->name) }}

                            ({{ translate($subscription->plan->is_lifetime ? 'Lifetime' : ucfirst($subscription->plan->invoice_interval . 'ly')) }}
                            )
                        </p>
                        <h6 class="counter-title">{{ translate('Plan Name') }}
                        </h6>
                    </div>
                    <div class="counter-icon">
                        <i class="fa-solid fa-crown"></i>
                    </div>
                </div>
            </div>
        </div>


        @if ($subscription->isOnTrial())
            {{-- Trial Ends --}}
            <div class="col-md-6">
                <div class="box h-100">
                    <div class="counter">
                        <div class="counter-info">
                            <p class="counter-amount">{{ ToDate($subscription->trial_ends_at) }}</p>
                            <h6 class="counter-title">{{ translate('Trial Ends At') }}</h6>
                        </div>
                        <div class="counter-icon">
                            <i class="fa-solid fa-hourglass-end"></i>
                        </div>
                    </div>
                </div>
            </div>
        @endif


        @if (!$subscription->isLifetime() && !$subscription->isOnTrial())
            {{-- Subscription Start --}}
            <div class="col-md-6">
                <div class="box h-100">
                    <div class="counter">
                        <div class="counter-info">
                            <p class="counter-amount">
                                {{ ToDate($subscription->ends_at) }}
                            </p>
                            <h6 class="counter-title">{{ translate('Subscription expiration date') }}</h6>
                        </div>
                        <div class="counter-icon">
                            <i class="fa-solid fa-play"></i>
                        </div>
                    </div>
                </div>
            </div>
        @endif
    </div>

    {{-- Transactions Title --}}
    <div class="row mt-5">
        <div class="col">
            <h4>{{ translate('Recent Transactions') }}</h4>
        </div>
    </div>

    <div class="box p-3">
        <div class="table-inner">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="text-center">{{ translate('Transaction ID') }}</th>
                            <th class="text-center">{{ translate('Plan (Interval)') }}</th>
                            <th class="text-center">{{ translate('Amount') }}</th>
                            <th class="text-center">{{ translate('Payment Method') }}</th>
                            <th class="text-center">{{ translate('Date') }}</th>
                            <th class="text-center">{{ translate('Status') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($transactions as $transaction)
                            <tr>
                                <td class="text-center">#{{ $transaction->transaction_id }}</td>
                                <td class="text-center">
                                    {{ translate($transaction->plan->name ?? 'None') . ' (' . translate($transaction->interval) }}
                                    )
                                </td>
                                <td class="text-center">{{ $transaction->amount . ' ' . $transaction->currency }}
                                </td>
                                <td class="text-center">{{ ucfirst(translate($transaction->gateway)) }}</td>

                                <td class="text-center">
                                    {{ ToDate($transaction->created_at) }}
                                </td>
                                <td class="text-center">
                                    <span class="badge {{ $transaction->getStatusColor() }}">
                                        {{ $transaction->getStatusName() }}</span>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
        <div class="table-footer mt-3">
            <div class="row row-cols-auto justify-content-between align-items-center g-3">
                <div class="col">
                    <span>
                        {{ translate('Showing') }} {{ $transactions->firstItem() }} {{ translate('to') }}
                        {{ $transactions->lastItem() }} {{ translate('of') }}
                        {{ $transactions->total() }} {{ translate('entries') }}
                    </span>
                </div>
                <div class="col">
                    {{ $transactions->appends(request()->query())->links() }}
                </div>
            </div>
        </div>
    </div>
@endsection
