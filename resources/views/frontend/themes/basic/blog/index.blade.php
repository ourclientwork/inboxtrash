@extends('frontend.themes.basic.layouts.app')

@section('alternate')
    @include('partials.alternate')
@endsection

@section('content')
    @include('frontend.themes.basic.partials.header', [
        'title' =>
            isset($query) && $query
                ? translate('Search Results for') . '"' . e($query) . '"'
                : translate('Blog', 'general'),
    ])

    <!-- Start Section -->
    <section class="section">
        <div class="container">
            <div class="section-inner">
                <div class="row g-4">
                    <div class="col-12 col-xl-8">
                        <div class="row row-cols-1 row-cols-lg-2 row-cols-xl-2 g-4 mb-4">
                            @forelse ($posts as $post)
                                <div class="col">
                                    <a href="{{ route('posts', $post->slug) }}" class="card h-100">
                                        <img src="{{ asset($post->small_image) }}" alt="{{ $post->title }}" />
                                        <div class="card-body">
                                            <h3 class="card-title mb-3">
                                                {{ $post->title }}
                                            </h3>
                                            <p class="card-text lead">{{ $post->description }}</p>
                                            <p class="card-text">
                                                <small class="text-muted">{{ ToDate($post->created_at, 'M d, Y') }}</small>
                                            </p>
                                        </div>
                                    </a>
                                </div>
                            @empty
                                <div class="col-12">
                                    <p class="lead">
                                        {{ isset($query) && $query ? translate('No results found for') . '"' . e($query) . '"' : translate('No posts available.') }}
                                    </p>
                                </div>
                            @endforelse ($posts as $post)
                        </div>
                        {{ $posts->links('pagination::bootstrap-4') }}
                    </div>
                    @include('frontend.themes.basic.blog.sidebar', ['query' => $query ?? null])
                </div>
            </div>
        </div>
    </section>
    <!-- End Section -->
@endsection
