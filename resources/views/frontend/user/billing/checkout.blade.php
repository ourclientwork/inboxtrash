@extends('frontend.user.layouts.app')
@section('body_class', 'toggle')


@section('content')
    <x-breadcrumb title="{{ translate('Checkout') }}" :nav="false" />

    <div class="row g-4">
        <div class="col-12 col-xl-8 order-2 order-xl-2">
            <div class="box">
                <div class="card-body">
                    <h4 class="mb-4">{{ translate('Account information') }}</h4>
                    <form>
                        <div class="row row-cols-1 row-cols-lg-2 g-3 mb-3">
                            <div class="col">
                                <x-input name='firstname' disabled required label="{{ translate('First Name', 'auth') }}"
                                    value="{{ $user->firstname }}" />
                            </div>
                            <div class="col">
                                <x-input name='firstname' disabled required label="{{ translate('Last Name', 'auth') }}"
                                    value="{{ $user->lastname }}" />
                            </div>

                            <div class="col col-lg-12">
                                <x-input name='firstname' disabled required label="{{ translate('Email', 'auth') }}"
                                    value="{{ $user->email }}" />
                            </div>
                        </div>

                    </form>
                </div>
            </div>
            <div class="box mt-4">
                <div class="card-body">
                    <h4 class="mb-4">{{ translate('Payment Methods') }}</h4>
                    <?php $i = 1; ?>
                    @foreach ($gateways as $gateway)
                        <div class="payment-method mb-3">
                            <div class="payment-info w-100">
                                <div class="row row-cols-auto justify-content-between flex-nowrap">
                                    <div class="col flex-shrink-1">
                                        <span class="payment-title">
                                            {{ $gateway->name }}
                                        </span>
                                    </div>
                                    <div class="col">
                                        <div class="payment-img">
                                            <img
                                                src="{{ asset('assets/img/payments/' . $gateway->unique_name . '.svg') }}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input @if ($gateway->unique_name == 'stripe' && 0 == 1) disabled @endif form="subscribe"
                                value="{{ $gateway->unique_name }}" class="form-check-input" type="radio" name="gateway"
                                @if ($i == 1) checked @endif id="{{ $gateway->unique_name }}">
                            <label class="form-check-label" for="{{ $gateway->unique_name }}"></label>
                        </div>
                        <?php $i++; ?>
                    @endforeach
                </div>
            </div>
        </div>
        <div class="col-12 col-xl-4 order-1 order-xl-2 d-flex flex-column">
            <div class="box mb-4">
                <div class="card-body">
                    <h4 class="mb-3">{{ translate('Order Summary') }}</h4>
                    <div class="border-top border-bottom py-4">
                        <div class="row row-cols-auto justify-content-between flex-nowrap text-muted ">
                            <div class="col">
                                <span>{{ translate('Plan') }}</span>
                            </div>
                            <div class="col">
                                <span>{{ translate($plan->name) }}</span>
                            </div>
                        </div>
                        <div class="row row-cols-auto justify-content-between flex-nowrap text-muted mt-3">
                            <div class="col">
                                <span>{{ translate('Interval') }} </span>
                            </div>
                            <div class="col">
                                <span>{{ $plan->is_lifetime == 1 ? translate('Lifetime') : translate(ucfirst($plan->invoice_interval) . 'ly') }}</span>
                            </div>
                        </div>
                        <hr>
                        <div class="row row-cols-auto justify-content-between flex-nowrap text-muted mt-3">
                            <div class="col">
                                <span>{{ translate('Price') }}</span>
                            </div>
                            <div class="col">
                                <span>{{ number_format($plan->price, 2) }} {{ getSetting('currency_code') }}</span>
                            </div>
                        </div>
                        @if ($coupon_code)
                            <div class="row row-cols-auto justify-content-between flex-nowrap text-muted mt-3">
                                <div class="col">
                                    <span>{{ translate('Discount', 'fantastic') }}</span>
                                </div>
                                <div class="col">
                                    <span>- {{ number_format($discount, 2) }} {{ getSetting('currency_code') }}
                                    </span>
                                </div>
                            </div>
                        @endif
                        <div class="row row-cols-auto justify-content-between flex-nowrap text-muted mt-3">
                            <div class="col">
                                <span>{{ translate('VAT', 'fantastic') }} ({{ $tax }}%)</span>
                            </div>
                            <div class="col">
                                <span>
                                    {{ number_format($calculate_tax, 2) }} {{ getSetting('currency_code') }}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="mt-4" id="discountDiv">
                        <form action="{{ route('checkout.coupon', encode_hash($plan->id)) }}" method="POST">
                            @csrf
                            <div class="input-group">
                                <input required type="text" name="discount"
                                    value="{{ old('discount') ?? $coupon_code }}" class="form-control form-control-md "
                                    placeholder="{{ translate('Discount Code', 'fantastic') }}">

                                <button type="submit" class="btn btn-primary btn-md">
                                    {{ translate('Submit', 'fantastic') }}
                                </button>
                            </div>
                            <x-error name="discount" class="text-start" />
                        </form>

                    </div>
                    <div class="row row-cols-auto align-items-center justify-content-between flex-nowrap text-muted mt-3">
                        <div class="col">
                            <a class="discount-btn link link-primary discount-btn">
                                {{ translate('Have a discount code?') }}
                            </a>
                        </div>
                        <div class="col">
                            <span class="h3 fw-bold text-primary">
                                {{ total($plan->price, $calculate_tax, $discount) }}
                                {{ getSetting('currency_code') }}</span>
                        </div>
                    </div>
                </div>
            </div>
            <form id="subscribe" action="{{ route('checkout.pay') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="hash" value="{{ encode_hash($plan->id) }}" />
                <input type="hidden" name="discount" value="{{ $coupon_code }}" />
            </form>
            <div class="d-none d-xl-block">
                <button form="subscribe" class="btn btn-primary btn-md w-100 mb-4">
                    {{ translate('Checkout btn') }}
                </button>
                <p class="text-muted mb-4">
                    {!! replacePlaceholders(translate('Checkout Policy'), [
                        'terms' => '<a href="' . getSetting('terms_of_service') . '">' . translate('Terms of Service', 'auth') . '</a>',
                        'privacy' => '<a href="' . getSetting('privacy_policy') . '">' . translate('Privacy Policy', 'auth') . '</a>',
                        'refund' => '<a href="' . getSetting('refund_policy') . '">' . translate('Refund Policy', 'auth') . '</a>',
                    ]) !!}

                </p>
            </div>

        </div>
    </div>

@endsection
