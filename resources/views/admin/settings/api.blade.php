@extends('admin.layouts.admin')
@section('title', 'Api')
@section('content')
    <!-- Settings -->
    <div class="settings">
        @include('admin.partials.settings')
        <!-- Settings Content -->
        <div class="settings-content w-100">
            <div class="box">
                <h5 class="mb-4">{{ __('Api Key') }}</h5>

                <form action="{{ route('admin.settings.api.update') }}" method="POST">
                    @csrf

                    <div class="row row-cols-1 g-3 mt-3">
                        <x-label name="Api Key" for="test_email" />
                        <div class="input-group">
                            <x-input readonly name='api_key'
                                value="{{ is_demo() ? 'Hidden in demo' : getSetting('api_key') }}" required
                                :show-errors="false" aria-label="Recipient's username" aria-describedby="button-addon2" />
                            <button id="gen_api" class="btn btn-outline-primary" type="button"
                                id="button-addon2">{{ __('Generate!') }}</button>
                        </div>
                        <x-error name="api_key" />

                        <div class="col">
                            <x-label name="Enable Api" for="enable_api" />
                            <select class="select-input" hidden name="enable_api" id="enable_api">
                                <option {{ getSetting('enable_api') == 1 ? 'selected' : '' }} value="1">
                                    {{ __('Enabled') }}
                                </option>
                                <option {{ getSetting('enable_api') == 0 ? 'selected' : '' }} value="0">
                                    {{ __('Disabled') }}
                                </option>
                            </select>
                            <x-error name="enable_api" />
                        </div>

                        <div class="col">
                            <x-button class="btn-md w-100" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- /Settings Content -->
    </div>
    <!-- /Settings -->
@endsection
