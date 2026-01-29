<div class="col">
    <div class="plan box h-100">
        <div class="plan-header">
            <div class="d-flex justify-content-between align-items-center gap-2 mb-3">
                <h6 class="plan-title">{{ translate($free_plan->name, 'plans') }}</h6>
                @if ($free_plan->is_featured)
                    <div class="plan-badge">{{ translate('Popular') }}</div>
                @endif
            </div>
            <div class="plan-price d-flex align-items-end mb-2">
                <p class="h1 mb-0">{{ getSetting('currency_symbol') }}0</p>
                <span class="ms-1 mb-2 text-muted">/ {{ translate('Forever') }}</span>
            </div>
            <p class="plan-text text-muted mb-0">
                {{ translate($free_plan->description, 'plans') }}
            </p>
        </div>

        <div class="plan-actions py-4 border-bottom">
            <div class="row row-cols-1 g-2">
                <div class="col">
                    @if ($user->subscriptions->count() == 0)
                        <a href="{{ route('checkout', encode_hash($free_plan->id)) }}"
                            class="btn btn-primary btn-md w-100">
                            {{ translate('Get Started') }} </a>
                    @else
                        @if ($free_plan->id != $plan_id)
                            <a href="{{ route('checkout', encode_hash($free_plan->id)) }}"
                                class="btn btn-primary btn-md w-100">
                                {{ translate('Choose Plan') }}
                            </a>
                        @else
                            <a href="javascript:void(0)" class="btn btn-outline-primary btn-md w-100 disabled">
                                {{ translate('Active') }}
                            </a>
                        @endif
                    @endif
                </div>
            </div>
        </div>
        <div class="plan-body mt-4">
            <div class="my-3 ">
                <h6 class="text-uppercase">{{ translate('Features') }}</h6>
            </div>
            <div class="row row-cols-1 g-2">
                @foreach ($free_plan->getFeaturesAttribute() as $feature)
                    <div class="col">
                        <div class="d-flex align-items-center flex-wrap gap-2 text-muted">
                            <!-- Start Plan Feature Icon -->
                            @if ($feature->value == 'false' || $feature->value == 0)
                                <i class="fa-solid fa-circle-xmark text-danger fs-6"></i>
                                <span>{{ translate($feature->name, 'plans') }}</span>
                            @else
                                <i class="fa-solid fa-circle-check text-success fs-6"></i>
                                <span>
                                    @if ($feature->value == 'true' || $feature->value == '-1')
                                        @if ($feature->tag != 'ads' && $feature->tag != 'premium_domains' && $feature->tag != 'attachments')
                                            {{ translate('Unlimited') }}
                                        @endif
                                    @elseif ($feature->tag != 'attachments' && $feature->tag != 'ads' && $feature->tag != 'premium_domains')
                                        {{ $feature->value }}
                                    @endif
                                    {{ translate($feature->name, 'plans') }}
                                </span>
                            @endif
                            <!-- End Plan Feature Icon -->
                        </div>
                    </div>
                    <!-- End Plan Feature -->
                @endforeach
            </div>
        </div>
    </div>
</div>
