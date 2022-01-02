import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/form_kategori_page.dart';
import 'package:laundry_app/pages/kategori_page.dart';
import 'package:laundry_app/pages/login_page.dart';
import 'package:laundry_app/pages/penyedia_history_page.dart';
import 'package:laundry_app/pages/penyedia_pesanan_berlangsung_page.dart';
import 'package:laundry_app/pages/penyedia_pesanan_page.dart';
import 'package:laundry_app/pages/profile_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;

class PenyediaHomePage extends StatefulWidget {
  const PenyediaHomePage({Key? key}) : super(key: key);

  @override
  _PenyediaHomePageState createState() => _PenyediaHomePageState();
}

class _PenyediaHomePageState extends State<PenyediaHomePage> {
  void _logout() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/logout');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Logout berhasil',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        StringConstant.deleteStorage();
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
      } else {
        Fluttertoast.showToast(
            msg: 'Data harus diisi',
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

  Map profil = {};

  void _getProfil() async {
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
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  List _pesananbaru = [];

  void _getPesanan() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/pesanan/baru');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          _pesananbaru = json.decode(response.body)['data'];
        });
      }
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  List _pesananBerlangsung = [];

  void _getPesananBerlangsung() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/pesanan/proses');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          _pesananBerlangsung = json.decode(response.body)['data'];
        });
      }
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  List _pesananSelesai = [];

  void _getPesananSelesai() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/pesanan/selesai');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          _pesananSelesai = json.decode(response.body)['data'];
        });
      }
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  @override
  void initState() {
    super.initState();
    _getProfil();
    _getPesanan();
    _getPesananBerlangsung();
    _getPesananSelesai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.local_laundry_service,
              color: Colors.white,
            ),
            Text(
              'LAUNDRY APP',
              style: heading2.copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ProfilePage()));
              },
              icon: Icon(Icons.person)),
          IconButton(
              onPressed: () {
                _logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  profil['laundry'] == null
                      ? Fluttertoast.showToast(
                          msg: 'Lengkapi data laundry kamu terlebih dahulu',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FormKategoriPage()));
                },
                child: Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Data Kategori Laundry')],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PenyediaPesananPage()));
                },
                child: Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pesanan Baru'),
                        Text(_pesananbaru.length.toString())
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PenyediaPesananBerlangsung()));
                },
                child: Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pesanan Berlangsung'),
                        Text(_pesananBerlangsung.length.toString())
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PenyediaHistoryPage()));
                },
                child: Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Riwayat Laundry'),
                        Text(_pesananSelesai.length.toString())
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
