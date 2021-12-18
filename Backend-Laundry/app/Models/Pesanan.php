<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pesanan extends Model
{
    use HasFactory;
    protected $table="pesanan";
    protected $primaryKey = 'id';

    protected $fillable = [
        'user_id',
        'laundry_id',
        'kategori_id',
        'berat',
        'tanggal',
        'estimasi_hari',
        'pengambilan',
        'harga',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function laundry()
    {
        return $this->belongsTo(Laundry::class, 'laundry_id');
    }

    public function kategori()
    {
        return $this->belongsTo(Kategori::class, 'kategori_id');
    }
}
