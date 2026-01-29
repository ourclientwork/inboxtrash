<?php

namespace App\Http\Controllers\Admin;

use Carbon\Carbon;
use App\Models\User;
use App\Services\ImageService;
use Lobage\Planify\Models\Plan;
use App\Services\UserFilterService;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreUserRequest;
use App\Http\Requests\Admin\UpdateUserRequest;
use App\Http\Requests\Filter\UserFilterRequest;


class UserController extends Controller
{

    protected $filterService;

    public function __construct(UserFilterService $filterService)
    {
        $this->filterService = $filterService;
    }


    public function index(UserFilterRequest $request)
    {
        $get_inactive_users = User::whereNull('email_verified_at')->count();
        $get_active_users = User::whereNotNull('email_verified_at')->where('status', 1)->count();
        $get_banned_users = User::where('status', 0)->get()->count();
        $get_all_users = User::all()->count();

        $users = $this->filterService->filterUsers($request);

        return view('admin.users.index', compact('users', 'get_all_users', 'get_inactive_users', 'get_active_users', 'get_banned_users'));
    }


    public function create()
    {
        return view('admin.users.create')->with('plans', Plan::where('tag', '!=', 'guest')->get());
    }


    public function store(StoreUserRequest $request, ImageService $imageService)
    {

        $plan = Plan::where('id', $request->plan)->first();

        if (!$plan) {
            showToastr(__('Please Select a Active Plan'), "error");
            return back();
        }

        $user = User::create([
            "firstname" => $request->firstname,
            "lastname" => $request->lastname,
            "email" => $request->email,
            "email_verified_at" => $request->email_status == 1 ? Carbon::now() : null,
            "status" => $request->account_status,
            "password" => \Hash::make($request->password),
        ]);

        if ($request->hasFile('avatar')) {
            $file = $imageService->storeAvatar($request->file('avatar'));  // Use the FileService
            $user->update(['avatar' => $file['filename']]);
        } else {
            $user->update(['avatar' => config('lobage.default_avatar')]);
        }

        $user->newSubscription(
            'main',
            $plan,
        );


        showToastr(__('lobage.toastr.success'));
        return redirect(route('admin.users.index'));
    }


    public function edit(User $user)
    {
        return view('admin.users.edit')->with('user', $user)->with('plans', Plan::where('tag', '!=', 'guest')->get());
    }


    public function update(UpdateUserRequest $request, User $user, ImageService $imageService)
    {
        $plan = Plan::find($request->plan);
        if (!$plan->is_lifetime && $request->ends_at == null) {
            showToastr(__('You need to select an end date'), "error");
            return back();
        }

        if ($user->email_verified_at) {
            $email_status = $user->email_verified_at;
        } else {
            $email_status = Carbon::now();
        }

        $user->update([
            $user->firstname = $request->firstname,
            $user->lastname = $request->lastname,
            $user->email = $request->email,
            $user->email_verified_at = $request->email_status == 1 ?  $email_status : null,
            $user->status = $request->account_status,
        ]);

        if ($request->password != null) {
            $user->update([
                "password" => \Hash::make($request->password)
            ]);
        }


        if ($request->hasFile('avatar')) {
            $file = $imageService->updateAvatar($request->file('avatar'), $user->avatar);  // Use the FileService
            $user->update(['avatar' => $file['filename']]);
        }


        if ($user->subscription('main')->plan_id != $request->plan) {
            $plan = Plan::find($request->plan);
            $user->subscription('main')->changePlan($plan, false);
        }

        if ($request->ends_at != $user->subscription('main')->ends_at) {
            $subscription = $user->subscription('main');
            $subscription->ends_at = $request->ends_at;

            $subscription->save();
        }

        showToastr(__('lobage.toastr.update'));
        return redirect(route('admin.users.index'));
    }


    public function destroy(User $user)
    {

        if ($user->avatar != config('lobage.default_avatar')) {
            removeFileOrFolder($user->avatar);
        }

        $user->subscription('main')->delete();

        $user->delete();

        showToastr(__('lobage.toastr.delete'));
        return back();
    }
}