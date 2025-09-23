<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Shop extends Model
{
    use HasFactory;

    public function up(): void {
        Schema::create('shops', function (Blueprint $table) {
        $table->id();
        $table->foreignId('user_id')->constrained()->onDelete('cascade'); // pemilik toko
        $table->string('name');
        $table->string('description')->nullable();
        $table->string('address')->nullable();
        $table->string('image')->nullable(); 
        $table->timestamps();
    });
    }
}
