<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class LikeController extends Controller
{
    public function toggleLike($productId)
    {
        $product = Product::find($productId);

        if (!$product) {
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        $user = auth()->user();

        $liked = $user->likedProducts()->where('product_id', $product->id)->exists();

        if ($liked) {
            $user->likedProducts()->detach($product->id); // unlike
            $status = 'unliked';
        } else {
            $user->likedProducts()->attach($product->id); // like
            $status = 'liked';
        }

        return response()->json([
            'message' => "Produk berhasil $status",
            'total_likes' => $product->likedByUsers()->count(),
            'user_liked' => !$liked
        ]);
    }

    public function likedProducts()
    {
        $user = auth()->user();
        $products = $user->likedProducts()->get();

        return response()->json($products);
    }


}
