<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdatePlanRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|max:255|min:2',
            'description' => 'required',
            'trial' => 'required|integer',
            'price' => 'required|regex:/^[0-9]+(\.[0-9][0-9]?)?$/',
            'type' => 'required|in:month,year,lifetime',
            'coupons' => 'nullable',
            'visible' => 'boolean|required',
            'position' => 'required|integer',
            'featured' => 'boolean|required',
            // features
            'domains' => 'required|integer',
            'history' => 'required|integer',
            'messages' => 'required|integer',
            'ads' => 'required',
            'attachments' => 'required',
            'premium_domains' => 'required',
            // features position
            'domains_position' => 'nullable|integer',
            'history_position' => 'nullable|integer',
            'messages_position' => 'nullable|integer',
            'ads_position' => 'nullable|integer',
            'attachments_position' => 'nullable|integer',
            'premium_domains_position' => 'nullable|integer',
        ];
    }
}
