<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Order;

class OrderController extends Controller
{
    public function payOrder(Request $request, $orderId)
    {
        $user = auth()->user(); // pastikan user login
        $order = Order::findOrFail($orderId);

        $request->validate([
            'total_amount' => 'required|numeric|min:0'
        ]);

        $totalAmount = $request->input('total_amount');

        // cek saldo cukup
        if ($user->balance < $totalAmount) {
            return response()->json(['message' => 'Saldo tidak cukup'], 402);
        }

        // kurangi saldo
        $user->balance -= $totalAmount;
        $user->save();

        // update order jadi paid
        $order->status = 'paid';
        $order->save();

        return response()->json([
            'message' => 'Pembayaran berhasil',
            'balance' => $user->balance,
            'order' => $order
        ], 200);
    }
}
