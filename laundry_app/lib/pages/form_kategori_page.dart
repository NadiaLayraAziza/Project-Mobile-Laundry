import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/home_page.dart';
import 'package:laundry_app/pages/penyedia_home_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;

class FormKategoriPage extends StatefulWidget {
  const FormKategoriPage({Key? key}) : super(key: key);

  @override
  _FormKategoriPageState createState() => _FormKategoriPageState();
}

class _FormKategoriPageState extends State<FormKategoriPage> {
  Map profil = {};
  List kategori = [];

  void _getKategori() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/me');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          profil = json.decode(response.body);
        });
      }

      var url1 = Uri.parse(StringConstant.BASEURL +
          '/kategori?laundry_id=' +
          profil['laundry']['id'].toString());
      var response1 = await http.get(
        url1,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          kategori = json.decode(response1.body)['data'];
        });
      }
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  @override
  void initState() {
    super.initState();
    _getKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Kategori Laundry',
          style: heading2.copyWith(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => profil['role'] == 'penyedia'
                    ? PenyediaHomePage()
                    : HomePage()));
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: kategori.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kategori[index]['jenis'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                _showModal(kategori[index]['id'].toString());
                              },
                              icon: Icon(Icons.edit))
                        ],
                      ),
                      Text(
                        kategori[index]['hargakg'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _showModal(String id) async {
    TextEditingController _harga = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future _submit() async {
      var url = Uri.parse(StringConstant.BASEURL + '/kategori/' + id);
      try {
        Map<String, String> requestBody = <String, String>{
          'hargakg': _harga.text,
        };
        Map<String, String> headers = <String, String>{
          'Authorization': 'Bearer ' + StringConstant.token
        };

        var response = await http.put(url, headers: headers, body: requestBody);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: json.decode(response.body)['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Future.delayed(Duration(seconds: 2), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => FormKategoriPage()));
          });
        } else {
          Fluttertoast.showToast(
              msg: 'error',
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
            title: Text('Update Harga'),
            content: Container(
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
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submit();
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
          );
        });
  }
}
