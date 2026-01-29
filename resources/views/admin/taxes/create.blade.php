@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Add New Tax' col="col-12 col-xl-8 col-xxl-8" backTo="{{ route('admin.taxes.index') }}" />
    <div>
        <div class="row g-3 justify-content-center">
            <div class="col-12 col-lg-8">
                <div class="row row-cols-1 g-3">
                    <div class="col">
                        <div class="box">
                            <form action="{{ route('admin.taxes.store') }}" method="POST">
                                @csrf
                                <div class="row row-cols-1 g-3">
                                    <div class="col">
                                        <x-input name='name' required label="Name" />
                                    </div>
                                    <div class="col">
                                        <label for="country" class="form-label">{{ __('Country') }} </label>
                                        <select class="select-input_search" name="country" id="country">
                                            <option {{ in_array('all', $taxcodes) ? 'disabled' : '' }} value="all">
                                                {{ __('Worldwide') }}</option>
                                            @foreach (config('countries') as $code => $name)
                                                <option {{ in_array($code, $taxcodes) ? 'disabled' : '' }}
                                                    value="{{ $code }}">({{ $code }}) -- {{ $name }}
                                                </option>
                                            @endforeach
                                        </select>
                                        <x-error name="country" />
                                    </div>

                                    <div class="col">
                                        <x-input step="0.01" min="0" max="100" type='number' name='rate'
                                            required label="Rate" />
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
