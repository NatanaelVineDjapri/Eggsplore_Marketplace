<?php

namespace Database\Seeders;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Database\Seeder;
use App\Models\Rating;
use App\Models\Product;
use App\Models\User;

class RatingSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();
        $products = Product::all();

        foreach ($products as $product) {
            $sampleUsers = $users->random(rand(1, $users->count())); 
            foreach ($sampleUsers as $user) {
                Rating::create([
                    'product_id' => $product->id,
                    'user_id' => $user->id,
                    'rating' => rand(1, 5),
                ]);
            }
        }
    }
}
