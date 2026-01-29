<?php

namespace App\Models;

use Lobage\Planify\Models\Plan;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Coupon extends Model
{
    use HasFactory;


    protected $fillable = [
        'code',
        'usage',
        'limit',
        'name',
        'type',
        'value',
        'expired_at',
        "applies_to_all"
    ];

    protected $casts = [
        'expired_at' => 'datetime',
    ];


    public function plans()
    {
        return $this->belongsToMany(Plan::class);
    }

    public function isValid()
    {
        return now()->isBefore($this->expired_at);
    }
}
