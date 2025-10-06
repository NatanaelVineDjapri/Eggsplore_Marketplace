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
        'shop_id',
        'image',
    ];

    protected $appends = ['average_rating'];

    public function getAverageRatingAttribute()
    {
        return $this->ratings->avg('rating') ?? 0;
    }


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

    public function ratings()
    {
        return $this->hasMany(Rating::class);
    }

    public function hasBeenPurchasedByCurrentUser()
    {
        if (!Auth::check()) {
            return false;
        }
        return OrderItem::where('product_id', $this->id)
            ->whereHas('order', function ($query) {
                $query->where('user_id', auth()->id())->where('status', 'completed');
            })
            ->exists();
    }

    public function hasBeenReviewedByCurrentUser()
    {
        if (!Auth::check()) {
            return false;
        }

        return $this->ratings()
            ->where('user_id', auth()->id())
            ->exists();
    }

    public static function trending()
{
    $products = self::with(['user', 'ratings'])
        ->get()
        ->filter(fn ($product) => $product->average_rating >= 4)
        ->sortByDesc('average_rating')
        ->take(10);

    if ($products->isEmpty()) {
        // fallback biar ga kosong
        return self::with(['user', 'ratings'])
            ->latest()
            ->take(10)
            ->get();
    }

    return $products->values();
}
}
