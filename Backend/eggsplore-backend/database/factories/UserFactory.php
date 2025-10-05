<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    public function definition(): array
    {
        $imagePaths = [
            '/images/products/eggsplore1.jpg',
            '/images/products/eggsplore2.jpg',
        ];

        return [
            'name' => $this->faker->name(),
            'email' => $this->faker->unique()->safeEmail(),
            'password' => Hash::make('password123'),
            'phone_number' => $this->faker->phoneNumber(),
            'address' => $this->faker->address(),
            'role' => 'user',
            'image' => $this->faker->randomElement($imagePaths), 
        ];
    }
}
