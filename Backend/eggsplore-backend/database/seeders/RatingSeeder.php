<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Rating;
use App\Models\Product;
use App\Models\User;
use App\Models\Order;
use App\Models\OrderItem;

class RatingSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();
        $products = Product::all();

        if ($users->isEmpty() || $products->isEmpty()) {
            return; 
        }

        $totalRatingsToCreate = 50; 
        
        for ($i = 0; $i < $totalRatingsToCreate; $i++) {
            
            // 1. Ambil User dan Product secara acak
            $user = $users->random();
            $product = $products->random();
            
            
            $shippingFee = 15000.00; 
            $itemsSubtotal = $product->price * rand(1, 2);
            $randomServiceFee = rand(100000, 1000000) / 100; // 1000.00 - 10000.00
            $totalAmount = $itemsSubtotal + $shippingFee + $randomServiceFee;

            $order = Order::create([
                'user_id' => $user->id,
                'items_subtotal' => $itemsSubtotal,
                'shipping_fee' => $shippingFee,
                'service_fee' => round($randomServiceFee, 2), 
                'total_amount' => round($totalAmount, 2),
                
                'shipping_address' => $user->address ?? fake()->address(), 
                'receiver_name' => $user->name,
                'receiver_phone' => $user->phone_number ?? fake()->phoneNumber(),
                'status' => 'completed', 
                'payment_method' => 'EggsplorePay',
            ]);

            // Membuat Order Item (Juga Unik)
            $orderItem = OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $product->id,
                'product_name' => $product->name,
                'shop_name' => 'Toko Dummy', 
                'price_at_purchase' => $product->price,
                'quantity' => 1,
            ]);

            // 3. BUAT RATING
            Rating::create([
                'product_id' => $product->id,
                'user_id' => $user->id,
                'order_item_id' => $orderItem->id, 
                'rating' => rand(1, 5),
                'ulasan' => fake()->realText(100), 
            ]);
        }
    }
}