@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Add New Plan' col="col col-xl-8 col-xxl-8" backTo="{{ route('admin.plans.index') }}" />
    <div>
        <div class="row g-3 justify-content-center">
            <div class="col col-lg-8">
                <div class="row row-cols-1 g-3">
                    <div class="col">
                        <div class="box">
                            <form action="{{ route('admin.plans.store') }}" method="POST">
                                @csrf
                                <div class="row row-cols-1 g-3">
                                    <div class="col">
                                        <x-input name='name' required label="name" />
                                    </div>

                                    <div class="col">
                                        <x-label name="Short Description" for='content' />
                                        <textarea required class="form-control" rows="3" id='description' name="description">{{ old('description') }}</textarea>
                                        <x-error name="description" />
                                    </div>

                                    <div class="col col-sm-6">
                                        <x-input name='trial' value="{{ old('trial') == null ? 0 : old('trial') }}"
                                            required label="trial" step="1" min="0" type='number' />
                                    </div>

                                    <div class="col col-sm-6">
                                        <x-input type='number' required name='price' step="0.01" min="0"
                                            label="Price" placeholder="9.99" />
                                    </div>

                                    <div class="col col-sm-6">
                                        <x-label name="Plan Type" for="type" />
                                        <select class="select-input" name="type" id="type">
                                            <option {{ old('type') == 'month' ? 'selected' : '' }} value="month">
                                                {{ __('Monthly') }}
                                            </option>
                                            <option {{ old('type') == 'year' ? 'selected' : '' }} value="year">
                                                {{ __('Yearly') }}
                                            </option>
                                            <option {{ old('type') == 'lifetime' ? 'selected' : '' }} value="lifetime">
                                                {{ __('Lifetime') }}
                                            </option>
                                        </select>
                                        <x-error name="type" />
                                    </div>


                                    <div class="col col-sm-6">
                                        <x-label name="featured" for="featured" />
                                        <select class="select-input" name="featured" id="featured">
                                            <option {{ old('featured') == '0' ? 'selected' : '' }} value="0">
                                                {{ __('No') }}
                                            </option>
                                            <option {{ old('featured') == '1' ? 'selected' : '' }} value="1">
                                                {{ __('Yes') }}
                                            </option>
                                        </select>
                                        <x-error name="featured" />
                                    </div>

                                    <div class="col col-sm-6">
                                        <x-label name="Visibility" for="visible" />
                                        <select class="select-input" name="visible" id="visible">
                                            <option {{ old('visible') == '1' ? 'selected' : '' }} value="1">Public
                                            </option>
                                            <option {{ old('visible') == '0' ? 'selected' : '' }} value="0">Unlisted
                                            </option>
                                        </select>
                                        <x-error name="visible" />
                                    </div>


                                    <div class="col  col-md-6">
                                        <x-input type='number' required name='position'
                                            value="{{ old('position') == null ? 0 : old('position') }}" min="0"
                                            placeholder="0" label="Position" id="position" />
                                    </div>

                                    <hr>


                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='domains' value="{{ old('domains') }}"
                                            step="1" min="-1" placeholder="0" label="Custom domains"
                                            id="domains" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='domains_position' min="0" placeholder="0"
                                            label="Position" value="{{ old('domains_position') }}" />
                                    </div>


                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='history' value="{{ old('history') }}"
                                            step="1" min="-1" placeholder="100" label="History size"
                                            id="history" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='history_position' min="0" placeholder="0"
                                            label="Position" value="{{ old('history_position') }}" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='messages' value="{{ old('messages') }}"
                                            step="1" min="-1" placeholder="0" label="Favorite Messages"
                                            id="messages" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='messages_position' min="0" placeholder="0"
                                            label="Position" value="{{ old('messages_position') }}" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-label name="Premium Domains" for="premium_domains" />

                                        <select class="select-input" name="premium_domains">
                                            <option value="true"
                                                {{ old('premium_domains') == 'true' ? 'selected' : '' }}>
                                                {{ __('On') }}
                                            </option>
                                            <option value="false"
                                                {{ old('premium_domains') == 'false' ? 'selected' : '' }}>
                                                {{ __('Off') }}
                                            </option>
                                        </select>
                                        <x-error name="premium_domains" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='premium_domains_position' min="0"
                                            placeholder="0" label="Position"
                                            value="{{ old('premium_domains_position') }}" />
                                    </div>


                                    <div class="col col-md-6 ">

                                        <x-label name="Ads" for="ads" />
                                        <select class="select-input" name="ads">

                                            <option value="1" {{ old('ads') == '1' ? 'selected' : '' }}>
                                                {{ __('Hide Ads') }}
                                            </option>
                                            <option value="0" {{ old('ads') == '0' ? 'selected' : '' }}>
                                                {{ __('Show Ads') }}
                                            </option>

                                        </select>
                                        <x-error name="ads" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='ads_position' min="0" placeholder="0"
                                            label="Position" value="{{ old('ads_position') }}" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-label name="See Attachments" for="attachments" />

                                        <select class="select-input" name="attachments">
                                            <option value="true" {{ old('attachments') == 'true' ? 'selected' : '' }}>
                                                {{ __('On') }}
                                            </option>
                                            <option value="false" {{ old('attachments') == 'false' ? 'selected' : '' }}>
                                                {{ __('Off') }}
                                            </option>
                                        </select>
                                        <x-error name="attachments" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' name='attachments_position' min="0"
                                            placeholder="0" label="Position"
                                            value="{{ old('attachments_position') }}" />
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
