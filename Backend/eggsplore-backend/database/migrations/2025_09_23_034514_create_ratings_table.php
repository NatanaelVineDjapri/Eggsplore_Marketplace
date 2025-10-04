<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Menggunakan nama tabel 'ratings' sesuai permintaan Anda
        Schema::create('ratings', function (Blueprint $table) {
            $table->id();
            
            // Kunci Transaksi (Wajib: Memastikan Review unik per item yang dibeli)
            // Ini yang membuat sistem Anda menjadi E-commerce Grade
            $table->foreignId('order_item_id')->constrained('order_items')->onDelete('cascade')->unique();
            
            // Kunci Produk (Untuk pencarian cepat semua ulasan berdasarkan produk)
            $table->foreignId('product_id')->constrained('products')->onDelete('cascade');
            
            // Siapa yang memberi review
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // Detail Review
            $table->unsignedTinyInteger('rating'); // 1-5
            
            // Menggunakan nama 'ulasan' sesuai permintaan Anda, tanpa field media
            $table->text('ulasan')->nullable(); 

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ratings');
    }
};