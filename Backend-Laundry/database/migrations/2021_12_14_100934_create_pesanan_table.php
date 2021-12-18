<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePesananTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pesanan', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->unsignedInteger('laundry_id');
            $table->foreign('laundry_id')->references('id')->on('laundry');
            $table->unsignedInteger('kategori_id');
            $table->foreign('kategori_id')->references('id')->on('kategori');
            $table->integer('berat');
            $table->date('tanggal');
            $table->integer('estimasi_hari');
            $table->string('pengambilan');
            $table->integer('harga');
            $table->string('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pesanan');
    }
}
