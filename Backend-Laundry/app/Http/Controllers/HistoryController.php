<?php

namespace App\Http\Controllers;

use App\Models\History;
use Illuminate\Http\Request;

class HistoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = History::latest()->get();
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
        $data = History::create([
            'id_user' => $request->id_user,
            'id_pesanan' => $request->id_pesanan,
            'id_laundry' => $request->id_laundry,
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
        $data = History::find($id);
        if (is_null($data)) {
            return response()->json(
                [
                    'status' => 404,
                    'message' => 'Data not found',
                    'data' => $data
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
    public function update(Request $request, History $history)
    {
        $history->id_user = $request->id_user;
        $history->id_pesanan = $request->id_pesanan;
        $history->id_laundry = $request->id_laundry;
        $history->status = $request->status;
        $history->save();

        return response()->json(
            [
                'status' => 200,
                'message' => 'Data updated successfully.',
                'data' => $history
            ]
        );
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(History $history)
    {
        $history->delete();

        return response()->json(
            [
                'status' => 200,
                'message' => 'Data deleted successfully'
            ]
        );
    }
}
