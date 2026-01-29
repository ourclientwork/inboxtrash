<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TrashMail extends Model
{

    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'email',
        'domain',
        'ip',
        'fingerprint',
        'expire_at'
    ];

    protected $dates = ['deleted_at', 'expire_at'];


    public function deleteOldRecords()
    {
        $recordsToDelete = $this->orderBy('id', 'desc')->skip(100)->get();
        $this->whereNotIn('id', $recordsToDelete->pluck('id'))->delete();
    }
}
