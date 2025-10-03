<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User; 
use App\Models\OrderItem; 

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 
        'status', 
        'total',
    ];
    
    // Relasi untuk mengetahui siapa yang membuat pesanan ini
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    // Relasi untuk mengetahui item apa saja yang ada di pesanan ini
    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }
}