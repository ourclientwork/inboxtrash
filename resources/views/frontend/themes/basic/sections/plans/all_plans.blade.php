<div class="d-flex justify-content-center mb-4">
    <div class="plan-switcher">
        @if ($monthly_plans->count() > 0)
            <span class="plan-switcher-item active">{{ translate('Monthly') }}</span>
        @endif
        @if ($yearly_plans->count() > 0)
            <span class="plan-switcher-item ">{{ translate('Yearly') }}</span>
        @endif

        @if ($lifetime_plans->count() > 0)
            <span class="plan-switcher-item">{{ translate('Lifetime') }}</span>
        @endif
    </div>
</div>
<div class="plans-item active">
    <div
        class="mt-3 row row-cols-1 row-cols-lg-2
                row-cols-xl-3 align-items-center align-items-xl-end
                justify-content-center g-4">
        @if ($free_plan)
            @include('frontend.themes.basic.sections.plans.free')
        @endif
        @foreach ($monthly_plans as $plan)
            @include('frontend.themes.basic.sections.plans.paid')
        @endforeach
    </div>
</div>
<div class="plans-item">
    <div
        class="mt-3 row row-cols-1 row-cols-lg-2 row-cols-xl-3 align-items-center align-items-xl-end justify-content-center g-4">
        @if ($free_plan)
            @include('frontend.themes.basic.sections.plans.free')
        @endif
        @foreach ($yearly_plans as $plan)
            @include('frontend.themes.basic.sections.plans.paid')
        @endforeach
    </div>
</div>
<div class="plans-item">
    <div
        class="mt-3 row row-cols-1 row-cols-lg-2 row-cols-xl-3 align-items-center align-items-xl-end justify-content-center g-4">
        @if ($free_plan)
            @include('frontend.themes.basic.sections.plans.free')
        @endif
        @foreach ($lifetime_plans as $plan)
            @include('frontend.themes.basic.sections.plans.paid')
        @endforeach
    </div>
</div>
