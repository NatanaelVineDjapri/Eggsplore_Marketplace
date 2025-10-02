<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Shop;
use App\Models\User;

class ShopSeeder extends Seeder
{
    public function run(): void
    {
        $users = User::all();

        if ($users->count() === 0) {
            $this->command->info('No users found, skipping shops seeding.');
            return;
        }

        // Buat 2 shop per user
        foreach ($users as $user) {
            Shop::factory()->count(2)->create([
                'user_id' => $user->id,
            ]);
        }
    }
}
