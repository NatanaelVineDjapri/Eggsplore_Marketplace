<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index(){
        $products = Product::with('user')->get();
        return response()->json($products);
    }

    public function showProduct($id){
        $product = Product::with(['user','likes','comments','payments'])->find($id);
        
        if(!$product){
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        return response()->json($product);
    }

    public function addProduct(Request $request){
        $request->validate([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'stock' => $request->stock,
            'user_id' => auth()->id(),
        ]);

        $product = Product::create($request->all());

        return response()->json([
            'message' => 'Product berhasil ditambahkan',
            'detailProduct' => $product
        ]);
    }

    public function updateProduct(Request $request, $id){
        $product = Product::find($id);

        if(!$product){
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        if($product->user_id != auth()->id()){
            return response()->json(['message' => 'Tidak punya akses'], 403);
        }
        $request->validate([
            'name' => 'sometimes|required|string',
            'description' => 'sometimes|nullable|string',
            'price' => 'sometimes|required|numeric',
            'stock' => 'sometimes|required|integer'
        ]);

        $product->update($request->only(['name', 'description', 'price','stock']));

        return response()->json([
            'message' => 'Produk berhasil diupdate',
            'detailProduct' => $product,
        ]);
    }

    public function deleteProduct($id){
        $product = Product::find($id);

        if(!$product){
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        if($product->user_id != auth()->id()){
            return response()->json(['message' => 'Tidak punya akses'], 403);
        }

        $product->delete();

        return response()->json(['message' => "Produk berhasil di delete"]);
    }

    public function trendingProduct(){
        $product = Product::trending();
        return response()->json($product);
    }
}
