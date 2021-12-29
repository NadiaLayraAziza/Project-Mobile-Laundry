import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/kategori_page.dart';
import 'package:laundry_app/pages/login_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_app/widgets/bottom_feedback.dart';

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
      print(response.body);
      if (response.statusCode == 200) {
        BottomFeedback.success(context, 'Selamat', 'Logout berhasil');
        StringConstant.deleteStorage();
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
      } else {
        BottomFeedback.error(context, 'Error', 'Logout gagal 😑');
      }
    } on SocketException {
      BottomFeedback.error(context, 'Error', 'No Internet connection 😑');
    } on HttpException {
      BottomFeedback.error(context, 'Error', "Couldn't find the post 😱");
    } on FormatException {
      BottomFeedback.error(context, 'Error', "Bad response format 👎");
    }
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
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => KategoriPage()));
                      },
                      child: Card(
                        color: Colors.grey[200],
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Text('Hello'),
                        ),
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