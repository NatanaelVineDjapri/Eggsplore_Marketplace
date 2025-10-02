<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\User;
use App\Models\Product;
use App\Models\Shop;

class ProductFactory extends Factory
{
    protected $model = Product::class;

    public function definition(): array
    {
        $user = User::inRandomOrder()->first();
        $shop = Shop::inRandomOrder()->first();

        return [
            'name' => $this->faker->randomElement(['Telur', 'Daging', 'Sayuran', 'Laptop', 'Meja', 'Bangku', 'Sepatu'])
                        . ' ' . $this->faker->words(2, true),
            'description' => $this->faker->paragraphs(2, true),
            'price' => $this->faker->numberBetween(10000, 500000), 
            'stock' => $this->faker->numberBetween(10, 500),
            'user_id' => $user?->id ?? 1, 
            'shop_id' => $shop?->id ?? 1,  
            'image' => 'https://picsum.photos/640/480?' . $this->faker->randomNumber(5, true),
        ];
    }
}
