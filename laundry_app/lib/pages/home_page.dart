import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/kategori_page.dart';
import 'package:laundry_app/pages/login_page.dart';
import 'package:laundry_app/pages/penyedia_history_page.dart';
import 'package:laundry_app/pages/profile_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            msg: 'Logout gagal',
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

  List _laundry = [];

  void _getLaundry() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/laundry');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          _laundry = json.decode(response.body)['data'];
        });
      }
    } on SocketException {
    } on HttpException {
    } on FormatException {}
  }

  @override
  void initState() {
    super.initState();
    _getLaundry();
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PenyediaHistoryPage()));
              },
              icon: Icon(Icons.history)),
          IconButton(
              onPressed: () {
                _logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih Laundry',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
          Expanded(
            child: ListView.builder(
                itemCount: _laundry.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => KategoriPage(
                                      id: _laundry[index]['id'].toString(),
                                    )));
                      },
                      child: Card(
                        color: Colors.grey[100],
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      width: 60,
                                      height: 60,
                                      imageUrl: _laundry[index]['gambar'] ??
                                          "https://drukasia.com/images/stripes/monk3.jpg",
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Color(0xFFEBEBF4),
                                        highlightColor: Color(0xFFEBEBF4),
                                        child: Container(
                                          color: primaryBlue,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(_laundry[index]['nama_laundry']),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
