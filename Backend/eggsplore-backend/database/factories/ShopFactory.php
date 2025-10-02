<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Shop;
use App\Models\User;

class ShopFactory extends Factory
{
    protected $model = Shop::class;

    public function definition(): array
    {
        return [
            'user_id' => User::inRandomOrder()->first()->id, 
            'name' => $this->faker->company,
            'description' => $this->faker->sentence(10),
            'address' => $this->faker->address,
            'image' => 'images/products/eggsplore1.jpg', 
        ];
    }
}
