@php
    $defaultLangCode = getSetting('default_language');
    $prefixDefaultLanguage = !getSetting('hide_default_lang');
    $allLangs = getAllLanguages();
    $host = request()->getSchemeAndHttpHost();
    $currentPath = request()->path();

    $segments = array_values(array_filter(explode('/', $currentPath)));
    if (!empty($segments) && in_array($segments[0], collect($allLangs)->pluck('code')->all())) {
        array_shift($segments);
    }

    $basePath = '/' . implode('/', $segments);
    $alternateUrls = [];
    foreach ($allLangs as $lang) {
        $targetPath =
            $prefixDefaultLanguage || $lang->code !== $defaultLangCode ? '/' . $lang->code . $basePath : $basePath;
        $alternateUrls[$lang->code] = rtrim($host, '/') . ($targetPath ?: '/');
    }
@endphp

<link rel="alternate" hreflang="x-default" href="{{ $alternateUrls[$defaultLangCode] ?? $host }}" />
@foreach ($alternateUrls as $langCode => $langUrl)
    <link rel="alternate" hreflang="{{ $langCode }}" href="{{ $langUrl }}" />
@endforeach
