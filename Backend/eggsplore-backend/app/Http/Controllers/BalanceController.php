<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class BalanceController extends Controller
{
    // Middleware auth:sanctum
    public function topUp(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1',
        ]);

        $user = Auth::user();
        if (!$user) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }

        // Tambah saldo
        $user->balance += $request->amount;
        $user->save();

        return response()->json([
            'message' => 'Top up berhasil',
            'balance' => $user->balance,
        ]);
    }

    // Opsional: bisa buat reduceBalance
    public function reduce(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1',
        ]);

        $user = Auth::user();
        if (!$user || $user->balance < $request->amount) {
            return response()->json(['message' => 'Saldo tidak cukup'], 400);
        }

        $user->balance -= $request->amount;
        $user->save();

        return response()->json([
            'message' => 'Pembayaran berhasil',
            'balance' => $user->balance,
        ]);
    }
}
