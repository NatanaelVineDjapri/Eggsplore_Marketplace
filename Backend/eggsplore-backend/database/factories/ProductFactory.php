<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\User;
use App\Models\Product;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->words(3, true),
            'description' => $this->faker->sentence(),
            'price' => $this->faker->numberBetween(100000, 1000000),
            'stock' => $this->faker->numberBetween(1, 20),
            'user_id' => User::inRandomOrder()->first()->id,
            'image' => 'images/products/' . $this->faker->image(public_path('images/products'), 640, 480, null, false)
        ];
    }
}
