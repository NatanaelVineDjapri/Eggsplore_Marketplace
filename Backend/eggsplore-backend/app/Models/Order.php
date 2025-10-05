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
        'user_id', 'items_subtotal', 'shipping_fee', 'service_fee', 
        'total_amount', 'shipping_address', 'receiver_name', 
        'receiver_phone', 'payment_method', 'status'
    ];

    const STATUS_PENDING = 'pending';
    const STATUS_PAID = 'paid';
    const STATUS_ON_PROCESS = 'on_process';
    const STATUS_SENT = 'sent';
    const STATUS_DELIVERED = 'delivered';
    const STATUS_COMPLETED = 'completed';
    const STATUS_CANCELLED = 'cancelled';
    
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }
}