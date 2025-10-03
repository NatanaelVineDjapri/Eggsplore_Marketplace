<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\BalanceController;
use App\Http\Controllers\CartController;

Route::post('register', [AuthController::class, 'register']);
Route::get('users', [AuthController::class, 'allUsers']);
Route::post('login', [AuthController::class, 'login']);
Route::post('verify-user', [AuthController::class, 'verifyUser']);
Route::put('change-password', [AuthController::class, 'changePassword']);

Route::middleware('auth:sanctum')->group(function() {
    Route::put('/user/profile', [AuthController::class, 'updateProfile']);

    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'getAuthenticatedUser']);

    Route::get('/products', [ProductController::class,'index']);
    Route::get('/products/random', [ProductController::class, 'randomProducts']);

    Route::post('/topup', [BalanceController::class, 'topUp']);
    Route::post('/reduce', [BalanceController::class, 'reduce']);

    Route::get('/products/{id}', [ProductController::class,'showProduct']);
    Route::post('/products', [ProductController::class,'addProduct']);
    Route::put('/products/{id}', [ProductController::class,'updateProduct']);
    Route::delete('/products/{id}', [ProductController::class,'deleteProduct']);

    Route::get('/products/trending', [ProductController::class,'trendingProduct']);

    Route::post('/products/{id}/rate', [ProductController::class,'rateProduct']);

    Route::get('/search', [SearchController::class, 'search']);

    Route::get('/messages/inbox', [MessageController::class, 'inbox']);
    Route::get('/messages/{user}', [MessageController::class, 'index']);
    Route::post('/messages/{user}', [MessageController::class, 'store']);
    Route::delete('/messages/{user}/{message}', [MessageController::class, 'destroy']);
    Route::get('/shops', [ShopController::class, 'index']);
    Route::get('/shops/{id}', [ShopController::class, 'showShop']);
    Route::post('/shops', [ShopController::class, 'makeShop']);
    Route::put('/shops/{id}', [ShopController::class, 'updateShop']);

    Route::post('/products/{id}/like', [LikeController::class, 'toggleLike']);
    Route::get('/user/liked-products', [LikeController::class, 'likedProducts']);
    Route::get('/shops/{id}/products', [ProductController::class, 'shopProducts']);
    Route::get('/products/{product}/reviews', [ProductController::class, 'productReviews']);

    Route::get('/cart', [CartController::class, 'showCart']);
    Route::post('/cart', [CartController::class, 'addCart']);
    Route::put('/cart/{itemId}', [CartController::class, 'updateCart']);
    Route::delete('/cart/{itemId}', [CartController::class, 'removeCart']);

    Route::get('/user/shop', [ShopController::class, 'getUserShop']);
    Route::get('/user', [AuthController::class, 'getAuthenticatedUser']);
});
