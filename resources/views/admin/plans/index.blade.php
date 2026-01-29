@extends('admin.layouts.admin')

@section('content')
    <x-breadcrumb title='Plans' GoTo="{{ route('admin.plans.create') }}" />

    <div class="box p-3">
        <div class="table-inner">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="text-center">{{ __('Name') }}</th>
                            <th class="text-center">{{ __('Subscriptions') }}</th>
                            <th class="text-center">{{ __('Type') }}</th>
                            <th class="text-center">{{ __('Visibility') }}</th>
                            <th class="text-center">{{ __('Created at') }}</th>
                            <th class="text-center">{{ __('Actions') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($plans as $plan)
                            <tr>

                                <td class="text-center">
                                    {{ $plan->name }}
                                </td>
                                <td class="text-center">
                                    {{ $plan->tag == 'guest' ? '---' : $plan->subscriptions->count() }}
                                </td>
                                <td class="text-center">
                                    @if ($plan->id != 2 && $plan->id != 1)
                                        @if ($plan->invoice_interval == 'month')
                                            <span class="badge bg-orange">{{ __('Monthly') }}</span>
                                        @elseif($plan->is_lifetime == 1)
                                            <span class="badge bg-purple">{{ __('Lifetime') }}</span>
                                        @else
                                            <span class="badge bg-blue">{{ __('Yearly') }}</span>
                                        @endif
                                    @else
                                        @if ($plan->tag == 'free')
                                            <span class="badge bg-teal">{{ __('Free') }}</span>
                                        @else
                                            <span class="badge bg-dark">{{ __('Guest') }} </span>
                                        @endif
                                    @endif
                                </td>
                                <td class="text-center">
                                    @if ($plan->is_active)
                                        <span class="badge bg-green-lt">{{ __('Public') }}</span>
                                    @else
                                        <span class="badge bg-red-lt">{{ __('Unlisted') }}</span>
                                    @endif
                                </td>
                                <td class="text-center">
                                    {{ toDate($plan->created_at, 'Y-m-d') }}
                                </td>


                                <td class="d-flex justify-content-center">
                                    <div class="d-flex gap-2">
                                        @if ($plan->id == 2 || $plan->id == 1)
                                            <a href="{{ route('admin.plans.' . $plan->tag) }}"
                                                class="btn btn-success cp-x-2">
                                                <i class="far fa-edit"></i>
                                            </a>
                                        @else
                                            <a href="{{ route('admin.plans.edit', $plan->id) }}"
                                                class="btn btn-success cp-x-2">
                                                <i class="far fa-edit"></i>
                                            </a>
                                        @endif

                                        @if ($plan->id != 2 && $plan->id != 1)
                                            <button class="btn btn-danger cp-x-2" data-bs-toggle="modal"
                                                data-bs-target="#deleteModal" data-id="{{ $plan->id }}"
                                                data-action="{{ route('admin.plans.destroy', $plan->id) }}">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        @else
                                            <button class="btn btn-danger cp-x-2" disabled>
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        @endif
                                    </div>
                                </td>

                            </tr>
                        @endforeach

                    </tbody>
                </table>
            </div>
        </div>

    </div>
    <x-delete-modal />
@endsection
