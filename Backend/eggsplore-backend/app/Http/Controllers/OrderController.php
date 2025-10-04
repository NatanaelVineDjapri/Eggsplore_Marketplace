<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Order;

class OrderController extends Controller
{
    public function payOrder(Request $request, $orderId)
    {
        $user = auth()->user(); 
        $order = Order::findOrFail($orderId);

        $request->validate([
            'total_amount' => 'required|numeric|min:0'
        ]);

        $totalAmount = $request->input('total_amount');

   
        if ($user->balance < $totalAmount) {
            return response()->json(['message' => 'Saldo tidak cukup'], 402);
        }

        $user->balance -= $totalAmount;
        $user->save();

        $order->status = 'paid';
        $order->save();

        return response()->json([
            'message' => 'Pembayaran berhasil',
            'balance' => $user->balance,
            'order' => $order
        ], 200);
    }
}
