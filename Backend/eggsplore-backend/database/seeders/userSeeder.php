<?php

namespace Database\Seeders;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'name' => 'Nael Dummy',
            'email' => 'nael@example.com',
            'password' => Hash::make('password123'),
        ]);

    
        User::factory()->count(10)->create(); // user random
    }
}
