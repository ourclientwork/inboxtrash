<?php

namespace App\Http\Controllers\Admin;

use Lobage\Planify\Models\Plan;
use App\Http\Controllers\Controller;
use Lobage\Planify\Models\PlanFeature;
use App\Http\Requests\Admin\StorePlanRequest;
use App\Http\Requests\Admin\UpdatePlanRequest;
use App\Http\Requests\Admin\UpdateFreePlanRequest;
use App\Http\Requests\Admin\UpdateGuestPlanRequest;
use Cviebrock\EloquentSluggable\Services\SlugService;


class PlanController extends Controller
{

    protected string $currency;

    public function __construct()
    {
        $this->currency = getSetting('currency_code');
    }


    public function index()
    {
        return view('admin.plans.index')->with('plans', Plan::with('subscriptions')->get());
    }


    public function create()
    {
        return view('admin.plans.create');
    }


    public function store(StorePlanRequest $request)
    {


        $tag = SlugService::createSlug(Plan::class, 'tag', $request->name);

        $plan = Plan::create([
            'tag' => $tag,
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'invoice_interval' => $request->type == "lifetime" ? 'year' : $request->type,
            'trial_period' => $request->trial,
            'tier' => $request->position,
            'currency' => $this->currency,
            'is_active' => $request->visible,
            'is_featured' => $request->featured,
        ]);

        $is_lifetime = 0;

        if ($request->type == "lifetime") {


            $is_lifetime = 1;

            $plan->update([$plan->is_lifetime = 1]);
        }

        $plan->features()->saveMany([
            new PlanFeature(['tag' => 'domains', 'name' => 'Custom domains', 'value' => $request->domains, 'sort_order' => $request->domains_position ?? 0]),
            new PlanFeature(['tag' => 'history', 'name' => 'History size', 'value' => $request->history, 'sort_order' => $request->history_position ?? 0]),
            new PlanFeature(['tag' => 'messages', 'name' => 'Favorite Messages', 'value' => $request->messages, 'sort_order' => $request->messages_position ?? 0]),
            new PlanFeature(['tag' => 'ads', 'name' => 'No Ads', 'value' => $request->ads, 'sort_order' => $request->ads_position ?? 0]),
            new PlanFeature(['tag' => 'attachments', 'name' => 'See Attachments', 'value' => $request->attachments, 'sort_order' => $request->attachments_position ?? 0]),
            new PlanFeature(['tag' => 'premium_domains', 'name' => 'Premium Domains', 'value' => $request->premium_domains, 'sort_order' => $request->premium_domains_position ?? 0]),
        ]);



        if ($request->featured == 1) {
            Plan::where('is_featured', '=', 1)->where('invoice_interval', $request->type)->where('is_lifetime', $is_lifetime)->update(['is_featured' => 0]);
        }

        showToastr(__('lobage.toastr.success'));
        return redirect(route('admin.plans.index'));
    }

    public function edit(Plan $plan)
    {
        if ($plan->tag === 'free' || $plan->tag === 'guest') {
            return redirect(route('admin.plans.' . $plan->tag));
        }

        return view('admin.plans.edit')->with('plan', $plan);
    }

    public function free()
    {
        $plan = Plan::where('tag', 'free')->first();

        if (count($plan->features) == 0) {

            $plan->features()->saveMany([
                new PlanFeature(['tag' => 'domains', 'name' => 'Custom domains', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'storage', 'name' => 'Messages storage (days)', 'value' => 2, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'history', 'name' => 'History size', 'value' => 20, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'messages', 'name' => 'Favorite Messages', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'ads', 'name' => 'No Ads', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'attachments', 'name' => 'See Attachments', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'premium_domains', 'name' => 'Premium Domains', 'value' => false, 'sort_order' => 0]),
            ]);
        }

        return view('admin.plans.free')->with('plan', $plan);
    }

    public function guest()
    {
        $plan = Plan::where('tag', 'guest')->first();


        if (count($plan->features) == 0) {

            $plan->features()->saveMany([
                new PlanFeature(['tag' => 'domains', 'name' => 'Custom domains', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'storage', 'name' => 'Messages storage (days)', 'value' => 2, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'history', 'name' => 'History size', 'value' => 20, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'messages', 'name' => 'Favorite Messages', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'ads', 'name' => 'No Ads', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'attachments', 'name' => 'See Attachments', 'value' => false, 'sort_order' => 0]),
                new PlanFeature(['tag' => 'premium_domains', 'name' => 'Premium Domains', 'value' => false, 'sort_order' => 0]),
            ]);
        }

        return view('admin.plans.guest')->with('plan', $plan);
    }


    public function update_free(UpdateFreePlanRequest $request)
    {

        $plan = Plan::where('tag', 'free')->first();

        $plan->update([
            $plan->name = $request->name,
            $plan->description = $request->description,
            $plan->tier = $request->position,
            $plan->currency = $this->currency,
            $plan->is_active = $request->visible,
        ]);

        $plan->getFeatureByTag('domains')->update(['value' => $request->domains, 'sort_order' => $request->domains_position ?? 0]);
        $plan->getFeatureByTag('history')->update(['value' => $request->history, 'sort_order' => $request->history_position ?? 0]);
        $plan->getFeatureByTag('messages')->update(['value' => $request->messages, 'sort_order' => $request->messages_position ?? 0]);
        $plan->getFeatureByTag('ads')->update(['value' => $request->ads, 'sort_order' => $request->ads_position ?? 0]);
        $plan->getFeatureByTag('attachments')->update(['value' => $request->attachments, 'sort_order' => $request->attachments_position ?? 0]);
        $plan->getFeatureByTag('premium_domains')->update(['value' => $request->premium_domains, 'sort_order' => $request->premium_domains_position ?? 0]);

        showToastr(__('lobage.toastr.update'));
        return redirect(route('admin.plans.index'));
    }


    public function update_guest(UpdateGuestPlanRequest $request, Plan $plan)
    {

        $plan = Plan::where('tag', 'guest')->first();

        $plan->update([
            $plan->name = $request->name,
        ]);

        $plan->getFeatureByTag('ads')->update(['value' => $request->ads]);
        $plan->getFeatureByTag('history')->update(['value' => $request->history]);
        $plan->getFeatureByTag('attachments')->update(['value' => $request->attachments]);
        $plan->getFeatureByTag('premium_domains')->update(['value' => $request->premium_domains]);

        showToastr(__('lobage.toastr.update'));
        return redirect(route('admin.plans.index'));
    }


    public function update(UpdatePlanRequest $request, Plan $plan)
    {

        if ($plan->tag === 'free' || $plan->tag === 'guest') {
            abort(404);
        }

        if ($request->featured == 1) {
            Plan::where('is_featured', '=', 1)->where('invoice_interval', $request->type)->update(['is_featured' => 0]);
        }

        $plan->update([
            $plan->name = $request->name,
            $plan->description = $request->description,
            $plan->price = $request->price,
            $plan->invoice_interval = $request->type == "lifetime" ? 'year' : $request->type,
            $plan->trial_period = $request->trial,
            $plan->tier = $request->position,
            $plan->currency = $this->currency,
            $plan->is_active = $request->visible,
            $plan->is_featured = $request->featured,
        ]);

        if ($request->type == "lifetime") {
            $plan->update([$plan->is_lifetime = 1]);
        } else {
            $plan->update([$plan->is_lifetime = 0]);
        }

        $plan->getFeatureByTag('domains')->update(['value' => $request->domains, 'sort_order' => $request->domains_position ?? 0]);
        $plan->getFeatureByTag('history')->update(['value' => $request->history, 'sort_order' => $request->history_position ?? 0]);
        $plan->getFeatureByTag('messages')->update(['value' => $request->messages, 'sort_order' => $request->messages_position ?? 0]);
        $plan->getFeatureByTag('ads')->update(['value' => $request->ads, 'sort_order' => $request->ads_position ?? 0]);
        $plan->getFeatureByTag('attachments')->update(['value' => $request->attachments, 'sort_order' => $request->attachments_position ?? 0]);
        $plan->getFeatureByTag('premium_domains')->update(['value' => $request->premium_domains, 'sort_order' => $request->premium_domains_position ?? 0]);

        showToastr(__('lobage.toastr.update'));
        return redirect(route('admin.plans.index'));
    }

    public function destroy(Plan $plan)
    {

        if ($plan->tag === 'free' || $plan->tag === 'guest') {
            abort(404);
        }

        if ($plan->subscriptions->count() > 0) {
            showToastr(__('This plan cannot be deleted. You have subscribers whose plan needs to be changed or delete them'), 'error');
            return redirect(route('admin.plans.index'));
        }

        $plan->coupons()->detach();
        $plan->forceDelete();
        showToastr(__('toastr.delete'));
        return back();
    }
}