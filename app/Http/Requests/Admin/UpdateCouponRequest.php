<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdateCouponRequest extends FormRequest
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
            'code' => 'required|max:255|unique:coupons,code,' . $this->coupon->id,
            'limit' => 'required|integer',
            'name' => 'required|string|min:2',
            'type' => 'boolean',
            'amount' => 'required|regex:/^[0-9]+(\.[0-9][0-9]?)?$/',
            'expiry_date' => 'nullable|date',
        ];
    }
}
