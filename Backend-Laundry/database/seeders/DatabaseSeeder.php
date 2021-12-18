<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'nama' => 'Penyedia',
            'email' => 'penyedia@gmail.com',
            'username' => 'penyedia',
            'password' => Hash::make('penyedia'),
            'telepon' => '08512341234',
            'alamat' => 'Alamat penyedia',
            'role' => 'penyedia'
        ]);
        User::create([
            'nama' => 'Pengguna',
            'email' => 'pengguna@gmail.com',
            'username' => 'pengguna',
            'password' => Hash::make('pengguna'),
            'telepon' => '08512341234',
            'alamat' => 'Alamat pengguna',
            'role' => 'pengguna'
        ]);
        // \App\Models\User::factory(10)->create();
    }
}
