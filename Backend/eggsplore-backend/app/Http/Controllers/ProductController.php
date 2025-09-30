<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function index(){
        $products = Product::with('user')->get();
        return response()->json($products);
    }

    public function showProduct($id){
        $product = Product::with(['user','likes','comments','payments','ratings'])->find($id);


        if(!$product){
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        $averageRating = $product->ratings->avg('rating');

        return response()->json([
            'product' => $product,
            'average_rating' => $averageRating
        ]);
    }


    public function addProduct(Request $request){
        $request->validate([
            'name' => 'required|string',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
            'stock' => 'required|integer',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048'
        ]);

        $data = $request->all();
        $data['user_id'] = auth()->id();

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('products', 'public');            
            $data['image'] = 'storage/' . $path;
        }

        $product = Product::create($data);

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
            'stock' => 'sometimes|required|integer',
            'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048'
        ]);

        $data = $request->only(['name','description','price','stock']);

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('products', 'public');            
            $data['image'] = 'storage/' . $path;
        }

        $product->update($data);

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

        return response()->json(['message' => "Produk berhasil dihapus"]);
    }

    public function trendingProduct(){
        $products = Product::trending();
        return response()->json($products);
    }

    public function rateProduct(Request $request, $id){
        $request->validate([
            'rating' => 'required|integer|min:1|max:5',
            'ulasan' => 'nullable|string|max:255',
        ]);

        $product = Product::find($id);
        
        if(!$product){
            return response()->json(['message'=>'Produk tidak ditemukan'], 404);
        }

        $rating = $product->ratings()->updateOrCreate(
            ['user_id'=>auth()->id()],
            ['rating'=>$request->rating]
        );

        return response()->json([
            'message'=>'Rating berhasil diberikan',
            'rating'=>$rating,
            'average_rating'=>$product->averageRating()
        ]);
    }

}
