<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Lobage\Planify\Models\Plan;


class Transaction extends Model
{
    use HasFactory;

    const STATUS_UNPAID = 0;
    const STATUS_COMPLETED = 1;
    const STATUS_PENDING = 2;
    const STATUS_CANCELED = 3;
    const STATUS_REFUNDED = 4;
    const STATUS_FAILED = 5;

    protected $fillable = [
        'user_id',
        'plan_id',
        'payment_id',
        'transaction_id',
        'payer_id',
        'gateway',
        'plan_price',
        'amount',
        'discount_amount',
        'coupon_code',
        'fees',
        'currency',
        'interval',
        'status',
        'tax_name',
        'tax_rate',
        'tax_amount',
        'payment_proof',
        'ip_address',
        'cancellation_reason',
        'payment_link',
        'paid_at',
    ];


    protected $casts = [
        'paid_at' => 'datetime',
    ];



    public function getStatusName()
    {
        switch ($this->status) {
            case self::STATUS_UNPAID:
                return 'Unpaid';
            case self::STATUS_COMPLETED:
                return 'Completed';
            case self::STATUS_PENDING:
                return 'Pending';
            case self::STATUS_CANCELED:
                return 'Canceled';
            case self::STATUS_FAILED:
                return 'Failed';
            case self::STATUS_REFUNDED:
                return 'Refunded';
            default:
                return 'Unknown';
        }
    }

    public function getStatusColor()
    {
        switch ($this->status) {
            case self::STATUS_UNPAID:
                return 'bg-cyan';
            case self::STATUS_COMPLETED:
                return 'bg-green';
            case self::STATUS_PENDING:
                return 'bg-orange';
            case self::STATUS_CANCELED:
                return 'bg-red';
            case self::STATUS_FAILED:
                return 'bg-pink';
            case self::STATUS_REFUNDED:
                return 'bg-dark';
            default:
                return 'bg-dark';
        }
    }



    public function getPlansColor()
    {
        switch ($this->interval) {
            case ('month'):
                return 'bg-cyan-lt';
            case ('year'):
                return 'bg-green-lt';
            default:
                return 'bg-yellow-lt';
        }
    }

    public function getGatewaysColor()
    {
        switch ($this->gateway) {
            case ('paypal'):
                return 'bg-blue';
            case ('free'):
                return 'bg-lime';
            case ('trial'):
                return 'bg-dark';
            case ('stripe'):
                return 'bg-purple';
            default:
                return 'bg-yellow';
        }
    }


    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function plan()
    {
        return $this->belongsTo(Plan::class);
    }
}
