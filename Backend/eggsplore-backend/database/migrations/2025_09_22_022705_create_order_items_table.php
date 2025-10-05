<?php
// database/migrations/YYYY_MM_DD_HHMMSS_create_order_items_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('order_items', function (Blueprint $table) {
            $table->id();
            
            $table->foreignId('order_id')->constrained('orders')->onDelete('cascade');

            $table->foreignId('product_id')->nullable()->constrained('products')->onDelete('set null'); 
            
            $table->string('product_name');
            $table->string('shop_name'); 
            $table->decimal('price_at_purchase', 10, 2);
            $table->integer('quantity');

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_items');
    }
};