<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Models\Product;
use App\Models\Order;
use App\Models\Cart;
use App\Models\CartItem;
use Throwable;

class CheckoutController extends Controller
{
    
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'shipping_address' => 'required|string|max:255',
            'receiver_name'    => 'required|string|max:255',
            'receiver_phone'   => 'required|string|max:20',
            'items'            => 'required|array|min:1',
            'items.*.product_id' => 'required|integer|exists:products,id',
            'items.*.quantity'   => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = $request->user();
        $items = $request->input('items');

        try {
            return DB::transaction(function () use ($user, $items, $request) {
                
                $itemsSubtotal = 0;
                $productDetailsForOrder = [];
                $products = Product::find(collect($items)->pluck('product_id'));

                foreach ($items as $item) {
                    $product = $products->firstWhere('id', $item['product_id']);

                    if ($product->stock < $item['quantity']) {
                        return response()->json([
                            'message' => "Stok untuk produk '{$product->name}' tidak mencukupi. Sisa {$product->stock}."
                        ], 409);
                    }

                    $itemsSubtotal += $product->price * $item['quantity'];
                    $productDetailsForOrder[] = [
                        'product_id' => $product->id,
                        'product_name' => $product->name,
                        'shop_name' => $product->shop->name, 
                        'price_at_purchase' => $product->price,
                        'quantity' => $item['quantity'],
                    ];
                }

                $shippingFee = 10000;
                $serviceFee = max(2000, $itemsSubtotal * 0.025);
                $totalAmount = $itemsSubtotal + $shippingFee + $serviceFee;

                if ($user->balance < $totalAmount) {
                    return response()->json(['message' => 'Saldo tidak mencukupi.'], 402);
                }
                
                $cart = Cart::where('user_id', $user->id)->first();
                if ($cart) {
                    $productIds = collect($items)->pluck('product_id')->toArray();
                    CartItem::where('cart_id', $cart->id)
                            ->whereIn('product_id', $productIds)
                            ->delete();
                }

                foreach ($items as $item) {
                    Product::find($item['product_id'])->decrement('stock', $item['quantity']);
                }
                $user->decrement('balance', $totalAmount);

                $order = Order::create([
                    'user_id' => $user->id,
                    'items_subtotal' => $itemsSubtotal,
                    'shipping_fee' => $shippingFee,
                    'service_fee' => $serviceFee,
                    'total_amount' => $totalAmount,
                    'shipping_address' => $request->shipping_address,
                    'receiver_name'    => $request->receiver_name,
                    'receiver_phone'   => $request->receiver_phone,
                    'payment_method' => 'EggsplorePay',
                    'status' => 'paid',
                ]);
                $order->items()->createMany($productDetailsForOrder);
                
                return response()->json([
                    'message' => 'Order berhasil dibuat!',
                    'order' => $order->load('items')
                ], 201);

            });
        } catch (Throwable $e) {
            return response()->json([
                'message' => 'Terjadi kesalahan pada server saat checkout.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}