<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

use App\Models\OrderItem; 
use App\Models\Order;     
use App\Models\Rating; 
use App\Models\User; 
use App\Models\Shop; 
use App\Models\Cart; 
use App\Models\Like; 

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'price',
        'stock',
        'user_id',
        'image',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function likes()
    {
        return $this->hasMany(Like::class);
    }

    public function likedByUsers()
    {
        return $this->belongsToMany(User::class, 'likes');
    }

    public function cart()
    {
        return $this->hasMany(Cart::class);
    }

    public function shop()
    {
        return $this->belongsTo(Shop::class);
    }

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }

    public function payments(){
       return $this->hasMany(Payment::class);
     }
    public function averageRating()  {
    return $this->ratings()->avg('rating') ?? 0;
    }

    public function trendingProduct()
    {
        $products = Product::where('rating', '>=', 4)
            ->orderBy('rating', 'desc')
            ->get();

        return response()->json($products);
    }


    public function ratings()
    {
        return $this->hasMany(Rating::class);
    }

}
