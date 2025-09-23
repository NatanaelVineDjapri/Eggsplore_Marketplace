<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ShopController;

Route::post('register', [AuthController::class, 'register']);
Route::get('users', [AuthController::class, 'allUsers']);
Route::post('login', [AuthController::class, 'login']);
Route::post('verify-user', [AuthController::class, 'verifyUser']);
Route::put('change-password', [AuthController::class, 'changePassword']);

Route::middleware('auth:sanctum')->group(function() {
    Route::post('/logout', [AuthController::class, 'logout']);
    
    Route::get('/products', [ProductController::class,'index']);
    Route::get('/products/{id}', [ProductController::class,'showProduct']);
    Route::post('/products', [ProductController::class,'addProduct']);
    Route::put('/products/{id}', [ProductController::class,'updateProduct']);
    Route::delete('/products/{id}', [ProductController::class,'deleteProduct']);

    Route::get('/products/trending', [ProductController::class,'trendingProduct']);

    Route::post('/products/{id}/rate', [ProductController::class,'rateProduct']);

    Route::get('/shops', [ShopController::class, 'index']);
    Route::get('/shops/{id}', [ShopController::class, 'showShop']);
    Route::post('/shops', [ShopController::class, 'makeShop']);
    Route::put('/shops/{id}', [ShopController::class, 'updateShop']);
});