<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;

class HomeController extends Controller
{

    public function index()
    {
        setMetaTags();
        return view()->theme('index');
    }


    public function dashboard()
    {
        return view('frontend.user.dashboard');
    }
}