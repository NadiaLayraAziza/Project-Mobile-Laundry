<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Laundry extends Model
{
    use HasFactory;
    protected $table="laundry";
    protected $primaryKey = 'id';

    protected $fillable = [
        'user_id',
        'nama_laundry',
        'gambar',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
