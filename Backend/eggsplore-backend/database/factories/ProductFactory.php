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
            'name' => $this->faker->randomElement(['Telur', 'Daging', 'Sayuran',"Laptop","Meja","Bangku","Sepatu"]) . ' ' . $this->faker->words(2, true),
            'description' => $this->faker->paragraphs(2, true),
            'price' => $this->faker->numberBetween(10000, 500000), 
            'stock' => $this->faker->numberBetween(10, 500),
            'user_id' => User::inRandomOrder()->first()->id,
            'image' => 'https://picsum.photos/640/480?' . $this->faker->randomNumber(5, true),
        ];
    }
}