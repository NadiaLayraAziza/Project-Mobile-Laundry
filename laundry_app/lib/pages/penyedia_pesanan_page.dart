import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/penyedia_history_page.dart';
import 'package:laundry_app/pages/penyedia_home_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;

class PenyediaPesananPage extends StatefulWidget {
  const PenyediaPesananPage({Key? key}) : super(key: key);

  @override
  _PenyediaPesananPageState createState() => _PenyediaPesananPageState();
}

class _PenyediaPesananPageState extends State<PenyediaPesananPage> {
  List _pesanan = [];

  void _getPesanan() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/pesanan/baru');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          _pesanan = json.decode(response.body)['data'];
        });
      }
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  @override
  void initState() {
    super.initState();
    _getPesanan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: _pesanan.length,
          itemBuilder: (BuildContext context, int index) {
            print(_pesanan[index]['user_id']);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => PenyediaHistoryPage()));
                },
                child: Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nama pengguna'),
                            Text(
                              _pesanan[index]['user']['nama'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nama kategori'),
                            Text(
                              _pesanan[index]['kategori']['jenis'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tanggal'),
                            Text(
                              _pesanan[index]['tanggal'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _showModalUpdate(
                                  _pesanan[index]['id'].toString());
                            },
                            child: Text('Update'))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _showModalUpdate(String id) async {
    TextEditingController _harga = TextEditingController();
    TextEditingController _berat = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    void _submitUpdate() async {
      try {
        var url = Uri.parse(StringConstant.BASEURL + '/harga/update/' + id);
        var response = await http.put(url, body: {
          'berat': _berat.text,
          'harga': _harga.text,
        }, headers: {
          'Authorization': 'Bearer ' + StringConstant.token
        });
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: 'Berhasil',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => PenyediaHomePage()));
        } else {
          Fluttertoast.showToast(
              msg: 'Gagal',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } on SocketException {
      } on HttpException {
      } on FormatException {}
    }

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Pesanan'),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _harga,
                          decoration: new InputDecoration(
                            labelText: "Harga",
                            labelStyle: TextStyle(color: primaryBlue),
                            focusColor: primaryBlue,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: primaryBlue)),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: primaryBlue)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Harga tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _berat,
                          decoration: new InputDecoration(
                            labelText: "Berat (kg)",
                            labelStyle: TextStyle(color: primaryBlue),
                            focusColor: primaryBlue,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: primaryBlue)),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: primaryBlue)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Berat tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _submitUpdate();
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryBlue)),
                              child: Text('Update'))),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
