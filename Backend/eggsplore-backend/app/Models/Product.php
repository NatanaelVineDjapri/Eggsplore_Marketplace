<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $fillable=[
        'name',
        'description',
        'price',
        'stock',
        'user_id',
        'image',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    // public function likes(){
    //     return $this->hasMany(Like::class);
    // }

    // public function cart(){
    //     return $this->hasMany(Cart::class);
    // }

    // public function comment(){
    //     return $this->hasMany(Comment::class);
    // }

    // public function shop() {
    //     return $this->belongsTo(Shop::class);
    // }


    // public function payments(){
    //     return $this->hasMany(Payment::class);
    // }

    public static function trending(){
        return self::with('user')->withCount('payments')->orderBy('payment_counts','desc')->get();
    }

    // public function ratings(){
    //     return $this->hasMany(Rating::class);
    // }

    // public function averageRating(){
    //     return $this->ratings()->avg('rating');
    // }
}
