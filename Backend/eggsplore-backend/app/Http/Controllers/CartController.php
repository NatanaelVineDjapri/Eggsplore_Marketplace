<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;

class CartController extends Controller
{
    public function showCart() {
        $user = auth()->user();
        $cart = $user->cart()->with('items.product.shop')->first(); 

        if (!$cart) {
            return response()->json([
                'cart_id' => null,
                'items' => [],
                'total_price' => 0
            ]);
        }

        return response()->json([
            'cart_id' => $cart->id,
            'items' => $cart->items->map(function($item) {
                return [
                    'id' => $item->id,
                    'quantity' => $item->quantity,
                    'subtotal' => $item->quantity * $item->product->price,
                    'product' => [
                        'id' => $item->product->id,
                        'name' => $item->product->name,
                        'price' => $item->product->price,
                        'image' => $item->product->image,
                        'shop' => [
                            'id' => $item->product->shop->id,
                            'name' => $item->product->shop->name,
                        ],
                    ],
                ];
            })->values(),
            'total_price' => $cart->totalPrice()
        ]);
    }

    public function addCart(Request $request) {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1'
        ]);

        $user = auth()->user();
        $cart = $user->cart;

        if (!$cart) {
            $cart = $user->cart()->create();
        }

        $item = $cart->items()->updateOrCreate(
            ['product_id' => $request->product_id],
            ['quantity' => $request->quantity]
        );

        $item->load('product.shop'); 

        return response()->json([
            'message' => 'Produk ditambahkan ke keranjang',
            'cart' => $cart,
            'item' => [
                'id' => $item->id,
                'quantity' => $item->quantity,
                'subtotal' => $item->quantity * $item->product->price,
                'product' => [
                    'id' => $item->product->id,
                    'name' => $item->product->name,
                    'price' => $item->product->price,
                    'image' => $item->product->image,
                    'shop' => [
                        'id' => $item->product->shop->id,
                        'name' => $item->product->shop->name,
                    ],
                ],
            ],
            'total_price' => $cart->totalPrice()
        ]);
    }

    public function updateCart(Request $request, $itemId) {
        $request->validate([
            'quantity' => 'required|integer|min:1'
        ]);

        $item = CartItem::findOrFail($itemId);
        $item->update(['quantity' => $request->quantity]);
        $item->load('product.shop');

        $cart = $item->cart;

        return response()->json([
            'message' => 'Jumlah diperbarui',
            'item' => [
                'id' => $item->id,
                'quantity' => $item->quantity,
                'subtotal' => $item->quantity * $item->product->price,
                'product' => [
                    'id' => $item->product->id,
                    'name' => $item->product->name,
                    'price' => $item->product->price,
                    'image' => $item->product->image,
                    'shop' => [
                        'id' => $item->product->shop->id,
                        'name' => $item->product->shop->name,
                    ],
                ],
            ],
            'cart' => $cart,
            'total_price' => $cart->totalPrice()
        ]);
    }

    public function removeCart($itemId) {
        $item = CartItem::findOrFail($itemId);
        $cart = $item->cart;
        $item->load('product.shop');
        $item->delete();

        return response()->json([
            'message' => 'Produk dihapus dari keranjang',
            'cart' => $cart,
            'total_price' => $cart->totalPrice()
        ]);
    }
}
