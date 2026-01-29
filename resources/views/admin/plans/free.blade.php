@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Edit Free Plan' col="col col-xl-8 col-xxl-8" backTo="{{ route('admin.plans.index') }}" />
    <div>
        <div class="row g-3 justify-content-center">
            <div class="col col-lg-8">
                <div class="row row-cols-1 g-3">
                    <div class="col">
                        <div class="box">
                            <form action="{{ route('admin.plans.update_free') }}" method="POST">
                                @csrf
                                @method('PUT')
                                <div class="row row-cols-1 g-3">
                                    <div class="col">
                                        <x-input name='name' required label="name" value="{{ $plan->name }}" />
                                    </div>

                                    <div class="col">
                                        <x-label name="Short Description" for='description' />
                                        <textarea required class="form-control" rows="3" id='description' name="description">{{ $plan->description }}</textarea>
                                        <x-error name="description" />
                                    </div>

                                    <div class="col col-sm-6">
                                        <x-label name="featured" for="featured" />
                                        <select class="select-input" name="featured" id="featured">
                                            <option {{ $plan->is_featured == '0' ? 'selected' : '' }} value="0">
                                                {{ __('No') }}
                                            </option>
                                            <option {{ $plan->is_featured == '1' ? 'selected' : '' }} value="1">
                                                {{ __('Yes') }}
                                            </option>
                                        </select>
                                        <x-error name="featured" />
                                    </div>

                                    <div class="col col-sm-6">
                                        <x-label name="Visibility" for="visible" />
                                        <select class="select-input" name="visible" id="visible">
                                            <option {{ $plan->is_active == '1' ? 'selected' : '' }} value="1">Public
                                            </option>
                                            <option {{ $plan->is_active == '0' ? 'selected' : '' }} value="0">Unlisted
                                            </option>
                                        </select>
                                        <x-error name="visible" />
                                    </div>

                                    <div class="col ">
                                        <x-input type='number' required name='position' min="0" placeholder="0"
                                            label="Position" value="{{ $plan->tier }}" />
                                    </div>

                                    <hr>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='domains' step="1" min="-1"
                                            placeholder="0" label="Custom domains"
                                            value="{{ $plan->getFeatureByTag('domains')->value }}" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='domains_position' min="0" placeholder="0"
                                            value="{{ $plan->getFeatureByTag('domains')->sort_order }}" label="Position" />
                                    </div>


                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='history'
                                            value="{{ $plan->getFeatureByTag('history')->value }}" step="1"
                                            min="-1" placeholder="100" label="History size" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='history_position' min="0" placeholder="0"
                                            label="Position" value="{{ $plan->getFeatureByTag('history')->sort_order }}" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='messages'
                                            value="{{ $plan->getFeatureByTag('messages')->value }}" step="1"
                                            min="-1" placeholder="0" label="Favorite Messages" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='messages_position' min="0" placeholder="0"
                                            label="Position"
                                            value="{{ $plan->getFeatureByTag('messages')->sort_order }}" />
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
                                        <x-input type='number' name='premium_domains_position' min="0"
                                            placeholder="0" label="Position"
                                            value="{{ $plan->getFeatureByTag('premium_domains')->sort_order }}" />
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
                                        <x-input type='number' name='ads_position' min="0" placeholder="0"
                                            label="Position" value="{{ $plan->getFeatureByTag('ads')->sort_order }}" />
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

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='attachments_position' min="0"
                                            placeholder="0" label="Position"
                                            value="{{ $plan->getFeatureByTag('attachments')->sort_order }}" />
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
