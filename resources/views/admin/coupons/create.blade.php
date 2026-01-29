@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Add New Coupon' col="col col-xl-8 col-xxl-8" backTo="{{ route('admin.coupons.index') }}" />
    <div>
        <div class="row g-3 justify-content-center">
            <div class="col col-lg-8">
                <div class="row row-cols-1 g-3">
                    <div class="col">
                        <div class="box">
                            <form action="{{ route('admin.coupons.store') }}" method="POST">
                                @csrf
                                <div class="row row-cols-1 g-3">
                                    <div class="col">
                                        <x-input name='name' required label="Name" />
                                    </div>
                                    <div class="col">
                                        <x-label name="Coupon Code" for="code" />
                                        <div class="input-group ">
                                            <x-input :show-errors="false" name='code' value="{{ $code }}"
                                                required />
                                            <button id="gen_code" class="btn btn-outline-primary"
                                                type="button">{{ __('Generate!') }}</button>
                                        </div>
                                        <x-error name="code" />
                                    </div>

                                    <div class="col col-md-6">
                                        <x-label name="Discount Type" />
                                        <select class="select-input" hidden name="type">

                                            <option {{ old('type') == 0 ? 'selected' : '' }} value="0">
                                                {{ __('Fixed Discount $') }}

                                            </option>
                                            <option {{ old('type') == 1 ? 'selected' : '' }} value="1">
                                                {{ __('Percentage %') }}
                                            </option>
                                        </select>
                                        <x-error name="type" />
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' required name='amount' step="0.01" min="0"
                                            label="Amount" />
                                    </div>


                                    <div class="col col-md-6 ">
                                        <x-input type='datetime-local' name='expiry_date' label="Expiry Date" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __("Leave it blank if you don't want it to expire") }}
                                        </small>
                                    </div>

                                    <div class="col col-md-6 ">
                                        <x-input type='number' min="-1" value="-1" required name='limit'
                                            label="Limit" />
                                        <small class="d-block form-text text-muted w-100">
                                            {{ __('-1 = Unlimited ') }}
                                        </small>
                                    </div>

                                    <div class="col">
                                        <!-- Checkbox to toggle plan selection -->
                                        <div class="mb-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="applies_to_all"
                                                    name="applies_to_all" value="1" checked>
                                                <label class="form-check-label" for="applies_to_all">
                                                    {{ __('Apply to all plans') }}
                                                </label>
                                            </div>
                                        </div>

                                        <!-- Plan selection (hidden if applies_to_all is checked) -->
                                        <div id="plans_select_wrapper"
                                            style="{{ old('applies_to_all', $coupon->applies_to_all ?? false) ? 'display:none;' : '' }}">
                                            <x-label name="plans" for="plans" />
                                            <select hidden class="js-example-basic-multiple select-input" name="plans[]"
                                                multiple="multiple">
                                                @foreach ($plans as $plan)
                                                    <option value="{{ $plan->id }}">{{ $plan->name }}</option>
                                                @endforeach

                                            </select>
                                            <x-error name="coupons" />
                                        </div>
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
