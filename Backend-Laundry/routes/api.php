<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\KategoriController;
use App\Http\Controllers\LaundryController;
use App\Http\Controllers\PesananController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('login', [AuthController::class, 'login']);

Route::group(['middleware' => 'auth-api'], function ($router) {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('me', [AuthController::class, 'me']);
    Route::post('refresh', [AuthController::class, 'refresh']);
    Route::get('/pesanan/baru', [PesananController::class, 'pesananBaru']);
    Route::get('/pesanan/proses', [PesananController::class, 'pesananberlangsung']);
    Route::get('/pesanan/selesai', [PesananController::class, 'riwayatPenyedia']);
    Route::get('/pesanan/riwayat', [PesananController::class, 'riwayatPengguna']);
    Route::put('/status/update/{id}', [PesananController::class, 'UpdateStatus']);
    Route::put('/harga/update/{id}', [PesananController::class, 'UpdateHarga']);
    Route::resource('kategori', KategoriController::class);
    Route::resource('laundry', LaundryController::class);
    Route::resource('pesanan', PesananController::class);
});
Route::post('register', [AuthController::class, 'register']);
