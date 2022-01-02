import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/home_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FormLaundryPage extends StatefulWidget {
  final String laundryId;
  final String kategoriId;
  const FormLaundryPage(
      {Key? key, required this.laundryId, required this.kategoriId})
      : super(key: key);

  @override
  _FormLaundryPageState createState() => _FormLaundryPageState();
}

class _FormLaundryPageState extends State<FormLaundryPage> {
  TextEditingController _tanggal = TextEditingController();
  TextEditingController _estimasi = TextEditingController();
  TextEditingController _pengambilan = TextEditingController();
  String pengambilan = '';
  final _formKey = GlobalKey<FormState>();

  void _handleRadioValueChange(String? value) {
    setState(() {
      pengambilan = value!;

      switch (pengambilan) {
        case 'diantar':
          break;
        case 'dijemput':
          break;
      }
    });
  }

  void _submit() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/pesanan');
      var response = await http.post(url, body: {
        'laundry_id': widget.laundryId,
        'kategori_id': widget.kategoriId,
        'tanggal': _tanggal.text,
        'estimasi_hari': _estimasi.text,
        'pengambilan': pengambilan,
        'berat': '0',
        'harga': '0',
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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Pesanan',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    controller: _tanggal,
                    onTap: () async {
                      DateTime? date = DateTime(1900);
                      date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      _tanggal.text = date.toString();
                    },
                    decoration: new InputDecoration(
                      labelText: "Tanggal",
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
                        return 'Tanggal tidak boleh kosong';
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
                    controller: _estimasi,
                    decoration: new InputDecoration(
                      labelText: "Estimasi Hari",
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
                        return 'Estimasi hari tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 'diantar',
                      groupValue: pengambilan,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text(
                      'Diantar',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 'dijemput',
                      groupValue: pengambilan,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text(
                      'Dijemput',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (pengambilan.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Lengkapi data terlebih dahulu',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              _submit();
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryBlue)),
                        child: Text('Pesan Sekarang'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
