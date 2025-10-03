<?php
// database/migrations/YYYY_MM_DD_HHMMSS_create_orders_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            $table->decimal('items_subtotal', 10, 2);
            $table->decimal('shipping_fee', 10, 2);
            $table->decimal('service_fee', 10, 2); 
            $table->decimal('total_amount', 10, 2);

            $table->string('shipping_address');
            $table->string('receiver_name');
            $table->string('receiver_phone');
            
            $table->string('payment_method')->default('EggsplorePay');
            $table->enum('status', ['pending', 'paid', 'on_process', 'sent', 'delivered', 'completed'])
                 ->default('pending');
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};