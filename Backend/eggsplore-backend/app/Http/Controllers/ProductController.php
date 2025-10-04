<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Rating;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\JsonResponse;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('user')->get();
        return response()->json($products);
    }

    public function showProduct($id)
    {
        $product = Product::with(['user','likes','ratings'])->find($id);

        if(!$product){
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        $averageRating = $product->ratings->avg('rating');

        $hasPurchased = $product->hasBeenPurchasedByCurrentUser();
        $hasReviewed = $product->hasBeenReviewedByCurrentUser();

        $productData = $product->toArray();

        $productData = array_merge($productData, [
            'has_purchased' => $hasPurchased,
            'has_reviewed' => $hasReviewed,
        ]);


        return response()->json([
            'product' => $productData,
            'average_rating' => $averageRating
        ]);
    }

    public function addProduct(Request $request)
    {
        $user = auth()->user();
        $shop = $user->shop;

        if (!$shop) {
            return response()->json(['message' => 'Anda harus membuat toko terlebih dahulu.'], 403);
        }

        try {
            $validatedData = $request->validate([
                'name' => 'required|string',
                'description' => 'nullable|string',
                'price' => 'required|numeric',
                'stock' => 'required|integer',
                'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048'
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'message' => 'Validasi gagal',
                'errors' => $e->errors()
            ], 422);
        }

        $productData = [
            'name' => $validatedData['name'],
            'description' => $validatedData['description'],
            'price' => $validatedData['price'],
            'stock' => $validatedData['stock'],
            'user_id' => $user->id,
            'shop_id' => $shop->id,
        ];

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('products', 'public');
            $productData['image'] = 'storage/' . $path;
        }

        $product = Product::create($productData);

        return response()->json([
            'message' => 'Produk berhasil ditambahkan',
            'detailProduct' => $product
        ], 201);
    }

    public function updateProduct(Request $request, $id)
    {
        $product = Product::find($id);

        if (!$product) {
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        if ($product->user_id != auth()->id()) {
            return response()->json(['message' => 'Tidak punya akses'], 403);
        }

        $request->validate([
            'name' => 'sometimes|required|string',
            'description' => 'sometimes|nullable|string',
            'price' => 'sometimes|required|numeric',
            'stock' => 'sometimes|required|integer',
            'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048'
        ]);

        $data = $request->only(['name', 'description', 'price', 'stock']);

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

    public function deleteProduct($id)
    {
        $product = Product::find($id);

        if (!$product) {
            return response()->json(['message' => 'Produk tidak ditemukan'], 404);
        }

        if ($product->user_id != auth()->id()) {
            return response()->json(['message' => 'Tidak punya akses'], 403);
        }

        $product->delete();

        return response()->json(['message' => "Produk berhasil dihapus"]);
    }

    public function trendingProduct()
    {
        $products = Product::trending();
        return response()->json($products);
    }

    public function randomProducts(Request $request)
    {
        $count = $request->query('count', 6);
        $products = Product::inRandomOrder()->take($count)->get();
        return response()->json($products);
    }

    public function rateProduct(Request $request, $productId): JsonResponse
    {
        if (!Auth::check()) {
            return response()->json(['message' => 'Anda harus login untuk memberikan ulasan.'], 401);
        }

        try {
            $request->validate([
                'rating' => 'required|integer|min:1|max:5',
                'comment' => 'nullable|string|max:1000',
            ]);
        } catch (ValidationException $e) {
            return response()->json(['message' => $e->getMessage()], 422);
        }

        $product = Product::find($productId);
        if (!$product) {
            return response()->json(['message' => 'Produk tidak ditemukan.'], 404);
        }

        if (!$product->hasBeenPurchasedByCurrentUser()) {
            return response()->json(['message' => 'Anda hanya dapat mengulas produk yang sudah Anda beli.'], 403);
        }

        if ($product->hasBeenReviewedByCurrentUser()) {
            return response()->json(['message' => 'Anda sudah memberikan ulasan untuk produk ini.'], 403);
        }

        $rating = Rating::create([
            'product_id' => $product->id,
            'user_id' => Auth::id(),
            'rating' => $request->rating,
            'ulasan' => $request->comment,
        ]);

        return response()->json([
            'message' => 'Ulasan berhasil disimpan.',
            'rating' => $rating,
        ], 200);
    }

    public function shopProducts(Request $request, $id)
    {
        $query = Product::where('shop_id', $id);

        if ($request->has('exclude')) {
            $query->where('id', '!=', $request->query('exclude'));
        }

        $products = $query->inRandomOrder()->limit(6)->get();

        return response()->json([
            'data' => $products
        ], 200);
    }

    public function productReviews(Product $product)
    {
        $reviews = Rating::where('product_id', $product->id)
                            ->with('user:id,name,image')
                            ->latest()
                            ->paginate(10);

        return response()->json($reviews);
    }
}
