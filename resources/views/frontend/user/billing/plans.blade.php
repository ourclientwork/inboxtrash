@extends('frontend.user.layouts.app')
@section('body_class', 'toggle')


@section('content')
    <x-breadcrumb title="{{ translate('Plans') }}" :nav="false" />

    <div class="plans mb-5">
        <div class="plan-switcher">
            <nav class="d-flex justify-content-center mb-4">
                <div class="btn-group" role="tablist">
                    @if (count($monthly_plans) > 0)
                        <button class="btn btn-outline-primary active" id="tab-month-button" data-bs-toggle="tab"
                            data-bs-target="#tab-month" type="button" role="tab" aria-controls="tab-month"
                            aria-selected="true">{{ translate('Monthly') }}</button>
                    @endif
                    @if (count($yearly_plans) > 0)
                        <button class="btn btn-outline-primary" id="tab-year-button" data-bs-toggle="tab"
                            data-bs-target="#tab-year" type="button" role="tab" aria-controls="tab-year"
                            aria-selected="false" tabindex="-1">{{ translate('Yearly') }}</button>
                    @endif
                    @if (count($lifetime_plans) > 0)
                        <button class="btn btn-outline-primary" id="tab-lifetime-button" data-bs-toggle="tab"
                            data-bs-target="#tab-lifetime" type="button" role="tab" aria-controls="tab-lifetime"
                            aria-selected="false" tabindex="-1">{{ translate('Lifetime') }}</button>
                    @endif
                </div>
            </nav>
        </div>

        <div class="tab-content">
            <div class="tab-pane fade show active" id="tab-month" role="tabpanel" aria-labelledby="tab-month-tab"
                tabindex="0">
                <div class="plans-row">
                    <div
                        class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 row-cols-md-2 g-3 align-items-center align-items-xl-end
                justify-content-center">
                        @if ($free_plan)
                            @include('frontend.user.billing.free')
                        @endif
                        @foreach ($monthly_plans as $plan)
                            @include('frontend.user.billing.paid')
                        @endforeach
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="tab-year" role="tabpanel" aria-labelledby="tab-year-tab" tabindex="0">
                <div class="plans-row">
                    <div
                        class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 row-cols-md-2 g-3 align-items-center align-items-xl-end
                justify-content-center">
                        @if ($free_plan)
                            @include('frontend.user.billing.free')
                        @endif
                        @foreach ($yearly_plans as $plan)
                            @include('frontend.user.billing.paid')
                        @endforeach
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="tab-lifetime" role="tabpanel" aria-labelledby="tab-lifetime-tab" tabindex="0">
                <div class="plans-row">
                    <div
                        class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 row-cols-md-2 g-3 align-items-center align-items-xl-end
                justify-content-center">
                        @if ($free_plan)
                            @include('frontend.user.billing.free')
                        @endif
                        @foreach ($lifetime_plans as $plan)
                            @include('frontend.user.billing.paid')
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
