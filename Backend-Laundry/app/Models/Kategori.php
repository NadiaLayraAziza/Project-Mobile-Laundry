<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kategori extends Model
{
    use HasFactory;
    protected $table="kategori";
    protected $primaryKey = 'id';

    protected $fillable = [
        'laundry_id',
        'jenis',
        'hargakg',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function laundry()
    {
        return $this->hasMany(Laundry::class);
    }
}
