@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Edit Guest Plan' col="col col-xl-8 col-xxl-8" backTo="{{ route('admin.plans.index') }}" />
    <div>
        <div class="row g-3 justify-content-center">
            <div class="col col-lg-8">
                <div class="row row-cols-1 g-3">
                    <div class="col">
                        <div class="box">
                            <form action="{{ route('admin.plans.update_guest') }}" method="POST">
                                @csrf
                                @method('PUT')
                                <div class="row row-cols-1 g-3">
                                    <div class="col">
                                        <x-input name='name' readonly required label="name"
                                            value="{{ $plan->name }}" />
                                    </div>

                                    <hr>
                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='history'
                                            value="{{ $plan->getFeatureByTag('history')->value }}" step="1"
                                            min="-1" placeholder="100" label="History size" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-label name="Premium Domains" for="premium_domains" />

                                        <select class="select-input" name="premium_domains">
                                            <option value="true"
                                                {{ $plan->getFeatureByTag('premium_domains')->value == 'true' ? 'selected' : '' }}>
                                                {{ __('On') }}
                                            </option>
                                            <option value="false"
                                                {{ $plan->getFeatureByTag('premium_domains')->value == 'false' ? 'selected' : '' }}>
                                                {{ __('Off') }}
                                            </option>
                                        </select>
                                        <x-error name="premium_domains" />
                                    </div>


                                    <div class="col col-md-6 ">

                                        <x-label name="Ads" for="ads" />
                                        <select class="select-input" name="ads">

                                            <option value="1"
                                                {{ $plan->getFeatureByTag('ads')->value == '1' ? 'selected' : '' }}>
                                                {{ __('Hide Ads') }}
                                            </option>
                                            <option value="0"
                                                {{ $plan->getFeatureByTag('ads')->value == '0' ? 'selected' : '' }}>
                                                {{ __('Show Ads') }}
                                            </option>

                                        </select>
                                        <x-error name="ads" />
                                    </div>


                                    <div class="col col-md-6 ">
                                        <x-label name="See Attachments" for="attachments" />

                                        <select class="select-input" name="attachments">
                                            <option value="true"
                                                {{ $plan->getFeatureByTag('attachments')->value == 'true' ? 'selected' : '' }}>
                                                {{ __('On') }}
                                            </option>
                                            <option value="false"
                                                {{ $plan->getFeatureByTag('attachments')->value == 'false' ? 'selected' : '' }}>
                                                {{ __('Off') }}
                                            </option>
                                        </select>
                                        <x-error name="attachments" />
                                    </div>

                                    <div class="col">
                                        <x-button class="w-100" />
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
