<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Shop;


class ShopController extends Controller
{
    public function index(){
        $shops = Shop::with('user')->get();
        return response()->json($shops);
    }

    public function showShop($id)
    {
        $shop = Shop::with('products')->find($id);

        if (!$shop) {
            return response()->json(['message' => 'Toko tidak ditemukan'], 404);
        }

        return response()->json(['data' => $shop]);
    }

    public function makeShop(Request $request){
        $request -> validate([
            'name' => 'required|string|max:255|unique:shops,name',
            'description' => 'nullable|string',
            'address' => 'nullable|string',
            'image' => 'image|max:2048'
        ]);

        if(Shop::where('name', $request->name)->exists()){
            return response()->json([
                'message' => 'Nama toko sudah dipakai, coba nama lain.'
            ], 400);
        }

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('shops', 'public');
        }

        $shop = Shop::create([
            'user_id' => $request->user()->id,
            'name' => $request->name,
            'description' => $request->description,
            'address' => $request->address,
            'image' => $request->image,
        ]);

        return response()->json([
            'message'=> 'Toko berhasil dibuat',
            'dataShop' => $shop,
        ]);

    }

    public function updateShop(Request $request, $id){
        $shop = Shop::find($id);
        if(!$shop){
            return response()->json(['message' => 'Toko tidak ditemukan'], 404);
        }

        if ($request->user()->id !== $shop->user_id) {
            return response()->json(['message' => 'User Tidak punya akses'], 403);
        }

        $request->validate([
            'name' => 'required|required|string|max:255|unique:shops,name,' . $shop->id,
            'description' => 'nullable|string',
            'address' => 'nullable|string',
            'image' => 'nullable|string',
        ]);

        $shop->update($request->only(['name','description','address','image']));

        return response()->json([
            'message'=> 'Toko berhasil diupdate',
            'dataShop' => $shop
        ]);

    }

    public function getUserShop(Request $request)
    {
        $user = $request->user();

        $shop = Shop::where('user_id', $user->id)->first();

        if (!$shop) {
            return response()->json(['message' => 'User does not have a shop'], 404);
        }

        return response()->json($shop);
    }
}
