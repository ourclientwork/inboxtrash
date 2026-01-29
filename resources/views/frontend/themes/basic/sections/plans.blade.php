@if ($monthly_plans->count() > 0 || $yearly_plans->count() > 0 || $lifetime_plans->count() > 0)
    <!-- Start Section -->
    <section class="section">
        <div class="container">
            <!-- Start Section Inner -->
            <div class="section-inner">
                <!-- Start Section Header -->
                <div class="section-header">
                    <div class="section-title-sm">
                        <span>{{ translate('Plans') }}</span>
                    </div>
                    <h2 class="section-title">{{ translate('Plans Title') }}</h2>
                    <p class="section-text lead mb-0">
                        {{ translate('Plans Description') }}
                    </p>
                </div>
                <!-- End Section Header -->
                <!-- Start Section Body -->
                <div class="section-body" data-aos="zoom-in">
                    @include('frontend.themes.basic.sections.plans.all_plans')
                </div>
                <!-- End Section Body -->
            </div>
            <!-- End Section Inner -->
        </div>
        <div class="section-bg section-shapes"></div>
    </section>
    <!-- End Section -->
@endif
