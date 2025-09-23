<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;

Route::post('register', [AuthController::class, 'register']);
Route::get('user', [AuthController::class, 'allUsers']);
Route::post('login', [AuthController::class, 'login']);
Route::post('verify-user', [AuthController::class, 'verifyUser']);
Route::put('change-password', [AuthController::class, 'changePassword']);

Route::middleware('auth:sanctum')->group(function() {
    Route::get('/products', [ProductController::class,'index']);
    Route::get('/products/{id}', [ProductController::class,'showProduct']);
    Route::post('/products', [ProductController::class,'addProduct']);
    Route::put('/products/{id}', [ProductController::class,'updateProduct']);
    Route::delete('/products/{id}', [ProductController::class,'deleteProduct']);

    Route::get('/products/trending', [ProductController::class,'trendingProduct']);

    Route::post('/products/{id}/rate', [ProductController::class,'rateProduct']);
});