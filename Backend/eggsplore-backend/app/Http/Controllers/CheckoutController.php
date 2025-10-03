<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class CheckoutController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:sanctum');
    }

    // Endpoint: POST /api/order/create
    public function store(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'payment_method' => 'required|string',
            'shipping_address' => 'required|string',
            'receiver_name' => 'required|string',
            'receiver_phone' => 'required|string',
            'total_amount' => 'required|numeric|min:1',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
        ]);
        
        $requestedTotal = $request->total_amount;
        $calculatedTotal = $this->calculateOrderTotal($request->items, $request->shipping_fee);
        
        if ($calculatedTotal['grand_total'] != $requestedTotal) {
            throw ValidationException::withMessages(['total_amount' => 'Perhitungan total pembayaran tidak valid. Harap ulangi proses checkout.']);
        }
        
        // Cek Saldo User (USER BAYAR)
        if ($user->balance < $calculatedTotal['grand_total']) {
            return response()->json(['message' => 'Saldo EggsplorePay tidak mencukupi.'], 402);
        }
        
        try {
            DB::beginTransaction();

            // DEDUCT BALANCE
            $user->decrement('balance', $calculatedTotal['grand_total']);
            
            $order = Order::create([
                'user_id' => $user->id,
                'items_subtotal' => $calculatedTotal['items_subtotal'],
                'shipping_fee' => $calculatedTotal['shipping_fee'],
                'service_fee' => $calculatedTotal['service_fee'],
                'total_amount' => $calculatedTotal['grand_total'],

                'shipping_address' => $request->shipping_address,
                'receiver_name' => $request->receiver_name,
                'receiver_phone' => $request->receiver_phone,
                'payment_method' => $request->payment_method,
                'status' => Order::STATUS_PAID,
            ]);

            foreach ($calculatedTotal['validated_items'] as $item) {
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $item['product_id'],
                    'product_name' => $item['product_name'],
                    'shop_name' => $item['shop_name'], 
                    'price_at_purchase' => $item['price'],
                    'quantity' => $item['quantity'],
                ]);
            }

            DB::commit();

            return response()->json([
                'message' => 'Checkout berhasil! Saldo telah terpotong.',
                'order' => $order->load('items'),
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Terjadi kesalahan saat memproses transaksi.', 'error' => $e->getMessage()], 500);
        }
    }
    

    public function show(Request $request, User $user)
    {
        if (Auth::id() !== $user->id) {
            return response()->json(['message' => 'Unauthorized access.'], 403);
        }
        
        $cartItems = $user->cartItems->load('product.shop'); 
        $calculatedTotal = $this->calculateOrderTotal($cartItems->toArray(), 10000.00); 
        
        return response()->json([
            'message' => 'Data checkout berhasil dimuat.',
            'data' => [
                'user' => $user,
                'cart_items' => $cartItems,
                'summary' => [
                    'items_subtotal' => $calculatedTotal['items_subtotal'],
                    'shipping_fee' => $calculatedTotal['shipping_fee'],
                    'service_fee' => $calculatedTotal['service_fee'],
                    'total_amount' => $calculatedTotal['grand_total'],
                ]
            ]
        ], 200);
    }
    
    // HELPER FUNCTION ASLI UNTUK MENGHITUNG TOTAL
    private function calculateOrderTotal(array $clientItems, $clientShippingFee)
    {
        $itemsSubtotal = 0;
        $validatedItems = [];
        
        $productIds = collect($clientItems)->pluck('product_id')->unique();
        $products = \App\Models\Product::whereIn('id', $productIds)->get()->keyBy('id');
        
        foreach ($clientItems as $clientItem) {
            $product = $products->get($clientItem['product_id']);
            
            if (!$product || $product->stock < $clientItem['quantity']) {
                throw ValidationException::withMessages(['items' => 'Stok produk tidak mencukupi atau produk tidak valid.']);
            }
            
            $itemsSubtotal += $product->price * $clientItem['quantity'];
            
            $validatedItems[] = [
                'product_id' => $product->id,
                'product_name' => $product->name,
                'shop_name' => $product->user->name ?? 'Toko Tidak Diketahui', 
                'price' => $product->price,
                'quantity' => $clientItem['quantity'],
            ];
        }

        $serviceFee = rand(100000, 1000000) / 100;
        $shippingFee = $clientShippingFee;
        
        $grandTotal = $itemsSubtotal + $shippingFee + $serviceFee;
        
        return [
            'items_subtotal' => $itemsSubtotal,
            'shipping_fee' => $shippingFee,
            'service_fee' => round($serviceFee, 2),
            'grand_total' => round($grandTotal, 2),
            'validated_items' => $validatedItems,
        ];
    }
}