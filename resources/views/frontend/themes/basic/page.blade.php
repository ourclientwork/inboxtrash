@extends('frontend.themes.basic.layouts.app')

@section('content')
    @include('frontend.themes.basic.partials.header', ['title' => $page->title])
    <!-- Start Section -->
    <section class="section">
        <div class="container">
            <div class="section-inner">
                @if ($ad = ad('mailbox_top'))
                    <div class="ad ad-h mx-auto mb-4">
                        {!! $ad !!}
                    </div>
                @endif
                <div class="viewbox-container">

                    <div>
                        <div class="viewbox">
                            <!-- Start Viewbox Body -->
                            <div class="viewbox-body v2 p-4">
                                {!! $page->content !!}
                            </div>
                        </div>
                        @if ($ad = ad('mailbox_bottom'))
                            <div class="ad ad-h mx-auto mt-3">
                                {!! $ad !!}
                            </div>
                        @endif
                    </div>

                </div>
            </div>
        </div>
    </section>

    @foreach (getSections() as $section)
        @if ($section->type == 'theme' && in_array($section->name, ['features', 'get_in_touch']))
            @include('frontend.themes.basic.sections.' . $section->name)
        @endif
    @endforeach
    <!-- End Section -->
@endsection
