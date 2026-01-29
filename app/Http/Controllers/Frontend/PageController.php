<?php

namespace App\Http\Controllers\Frontend;


use App\Models\Page;
use App\Http\Controllers\Controller;

class PageController extends Controller
{

    public function index($slug)
    {

        $page = Page::where('slug', $slug)->firstorfail();

        if ($page['status'] == 1) {

            if ($page['lang'] ==  getCurrentLang()) {

                $page->incrementViewCount();

                setMetaTags(
                    $page->meta_title ?? $page->title,
                    $page->meta_description ?? substr(strip_tags($page->content), 0, 155)
                );

                return view()->theme('page')->with('page', $page);
            } else {
                return redirect(route('index'));
            }
        } else {
            abort(404);
        }
    }
}
