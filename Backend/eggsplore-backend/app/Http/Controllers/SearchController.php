<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Shop;

class SearchController extends Controller
{

    public function search(Request $request)
    {
        $query = $request->input('q');

        if (!$query) {
            return response()->json([
                'message' => 'Masukkan kata kunci untuk search'
            ], 400);
        }

        $products = Product::where('name', 'like', "%{$query}%")
            ->orWhere('description', 'like', "%{$query}%")
            ->get();

        $shops = Shop::where('name', 'like', "%{$query}%")
            ->orWhere('description', 'like', "%{$query}%")
            ->orWhere('address', 'like', "%{$query}%")
            ->get();

        return response()->json([
            'query' => $query,
            'products' => $products,
            'shops' => $shops
        ]);
    }
}
