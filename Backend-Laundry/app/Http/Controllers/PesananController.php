<?php

namespace App\Http\Controllers;

use App\Models\Pesanan;
use App\Models\User;
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

    public function pesananBaru()
    {
        $user = User::with('laundry')->where('id', auth()->user()->id)->first();
        $data = Pesanan::with(['user', 'laundry', 'kategori'])->where('laundry_id', $user->laundry->id)->where('status', 'Belum Dikonfirmasi')->get();
        return response()->json(
            [
                'status' => 200,
                'message' => 'Data berhasil ditampilkan',
                'data' => $data
            ]
        );
    }

    public function pesananBerlangsung()
    {
        $user = User::with('laundry')->where('id', auth()->user()->id)->first();
        $data = Pesanan::with(['user', 'laundry', 'kategori'])->where('laundry_id', $user->laundry->id)->where('status', 'Proses')->get();
        return response()->json(
            [
                'status' => 200,
                'message' => 'Data berhasil ditampilkan',
                'data' => $data
            ]
        );
    }

    public function riwayatPenyedia()
    {
        $user = User::with('laundry')->where('id', auth()->user()->id)->first();
        $data = Pesanan::with(['user', 'laundry', 'kategori'])->where('laundry_id', $user->laundry->id)->where('status', 'Selesai')->get();
        return response()->json(
            [
                'status' => 200,
                'message' => 'Data berhasil ditampilkan',
                'data' => $data
            ]
        );
    }

    public function riwayatPengguna()
    {
        $data = Pesanan::with(['user', 'laundry', 'kategori'])->where('user_id', auth()->user()->id)->get();
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
            'user_id' => auth()->user()->id,
            'laundry_id' => $request->laundry_id,
            'kategori_id' => $request->kategori_id,
            'tanggal' => $request->tanggal,
            'estimasi_hari' => $request->estimasi_hari,
            'pengambilan' => $request->pengambilan,
            'berat' => $request->berat,
            'harga' => $request->harga,
            'status' => 'Belum Dikonfirmasi',
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

    public function UpdateStatus(Request $request, $id)
    {
        $pesanan = Pesanan::find($id);
        $pesanan->update([
            'status' => 'Selesai'
        ]);


        return response()->json(
            [
                'status' => 200,
                'message' => 'Status updated successfully.',
                'data' => $pesanan
            ]
        );
    }

    public function UpdateHarga(Request $request, $id)
    {
        $pesanan = Pesanan::find($id);
        $pesanan->update([
            'berat' => $request->berat,
            'harga' => $request->harga,
            'status' => 'Proses'
        ]);

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
