<div class="col">
    <!-- Start Plan -->
    <div class="plan">
        @if ($free_plan->is_featured)
            <div class="card__ribbon" data-ribbon="{{ translate('Special Offers') }}"></div>
        @endif
        <!-- Start Plan Title -->
        <h5 class="plan-title">{{ translate($free_plan->name, 'plans') }}</h5>
        <!-- End Plan Title -->
        <!-- Start Plan Monthly -->
        <div class="plan-monthly">
            <!-- Start Plan Price -->
            <p class="plan-price mb-2">{{ translate('Free', 'plans') }}</p>
            <!-- End Plan Price -->
        </div>
        <!-- End Plan Monthly -->
        <!-- Start Plan Text -->
        <p class="plan-text lead">
            {{ translate($free_plan->description, 'plans') }}
        </p>
        <!-- End Plan Text -->

        <a href="{{ route('register') }}"
            class="btn @if ($free_plan->is_featured) btn-primary @else btn-outline-primary @endif btn-xl w-100">
            {{ translate('Get Started') }} </a>


        <!-- Start Plan Features -->
        <div class="plan-features">
            @foreach ($free_plan->getFeaturesAttribute() as $feature)
                <!-- Start Plan Feature -->
                <div class="plan-feat">
                    <!-- Start Plan Feature Icon -->
                    @if ($feature->value == 'false' || $feature->value == 0)
                        <div class="plan-feat-icon-v2">
                            <i class="fas fa-times"></i>
                        </div>
                        {{ translate($feature->name, 'plans') }}
                    @else
                        <div class="plan-feat-icon">
                            <i class="fa fa-check"></i>
                        </div>
                        @if ($feature->value == 'true' || $feature->value == '-1')
                            @if ($feature->tag != 'ads' && $feature->tag != 'premium_domains' && $feature->tag != 'attachments')
                                {{ translate('Unlimited') }}
                            @endif
                        @elseif ($feature->tag != 'attachments' && $feature->tag != 'ads' && $feature->tag != 'premium_domains')
                            {{ $feature->value }}
                        @endif
                        {{ translate($feature->name, 'plans') }}
                    @endif
                    <!-- End Plan Feature Icon -->
                </div>
                <!-- End Plan Feature -->
            @endforeach
        </div>
        <!-- End Plan Features -->
    </div>
    <!-- End Plan -->
</div>
