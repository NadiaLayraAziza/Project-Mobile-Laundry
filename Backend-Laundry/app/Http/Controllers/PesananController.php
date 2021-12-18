<?php

namespace App\Http\Controllers;

use App\Models\Pesanan;
use Illuminate\Http\Request;

class PesananController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = Pesanan::latest()->get();
        return response()->json(
            [
                'status' => 200,
                'message' => 'Data berhasil ditampilkan',
                'data' => $data
            ]
        );
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = Pesanan::create([
            'user_id' => $request->user_id,
            'laundry_id' => $request->laundry_id,
            'kategori_id' => $request->kategori_id,
            'berat' => $request->berat,
            'tanggal' => $request->tanggal,
            'estimasi_hari' => $request->estimasi_hari,
            'pengambilan' => $request->pengambilan,
            'harga' => $request->harga,
            'status' => $request->status,
         ]);

        return response()->json(
            [
                'status' => 200,
                'message' => 'Data created successfully.',
                'data' => $data
            ]
        );
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Pesanan::find($id);
        if (is_null($data)) {
            return response()->json(
                [
                    'status' => 404,
                    'message' => 'Data not found'
                ]
            );
        }

        return response()->json(
            [
                'status' => 200,
                'message' => 'Data berhasil ditampilkan',
                'data' => $data
            ]
        );
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Pesanan $pesanan)
    {
        $pesanan->user_id = $request->user_id;
        $pesanan->laundry_id = $request->laundry_id;
        $pesanan->kategori_id = $request->kategori_id;
        $pesanan->berat = $request->berat;
        $pesanan->tanggal = $request->tanggal;
        $pesanan->estimasi_hari = $request->estimasi_hari;
        $pesanan->pengambilan = $request->pengambilan;
        $pesanan->harga = $request->harga;
        $pesanan->status = $request->status;
        $pesanan->save();

        return response()->json(
            [
                'status' => 200,
                'message' => 'Data updated successfully.',
                'data' => $pesanan
            ]
        );
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Pesanan $pesanan)
    {
        $pesanan->delete();

        return response()->json(
            [
                'status' => 200,
                'message' => 'Data deleted successfully'
            ]
        );
    }
}
