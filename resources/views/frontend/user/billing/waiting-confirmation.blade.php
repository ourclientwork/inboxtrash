@extends('frontend.user.layouts.app')
@section('body_class', 'toggle') {{-- Or adjust if needed --}}

@section('content')

    <div class="row justify-content-center g-4">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="box mt-5">
                <div class="card-body text-center">
                    <h4 class="mb-4">{{ translate('Processing Your Payment') }}</h4>
                    <div class="mb-3">
                        {{-- Optional: Add a spinner --}}
                        <div class="d-flex justify-content-center">
                            <div class="spinner"></div>
                        </div>
                    </div>

                    <p class="text-muted mb-4">
                        {{ translate('Please wait while we securely confirm your payment. This should only take a moment.') }}
                        <br>
                        {{ translate('You will be redirected automatically once completed.') }}
                    </p>

                    {{-- Progress Bar --}}
                    <div class="progress progress-pay" role="progressbar" aria-label="Payment Processing Progress"
                        aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary"
                            id="paymentProgressBar" style="">0%
                        </div>
                    </div>
                    <p id="statusMessage" style="">{{ translate('Preparing your payment...') }}</p>

                </div>
            </div>
        </div>
    </div>
@endsection
