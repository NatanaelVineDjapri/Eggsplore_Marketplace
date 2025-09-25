<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::get('user/{id}', [AuthController::class, 'profile']);
// Route::put('user/{id}', [authController::class, 'update']);
Route::delete('user/{id}', [AuthController::class,'destroy']);
