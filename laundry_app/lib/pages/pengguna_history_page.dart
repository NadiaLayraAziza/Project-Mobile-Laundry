import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/penyedia_pesanan_berlangsung_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;

class PenggunaHistoryPage extends StatefulWidget {
  const PenggunaHistoryPage({Key? key}) : super(key: key);

  @override
  _PenggunaHistoryPageState createState() => _PenggunaHistoryPageState();
}

class _PenggunaHistoryPageState extends State<PenggunaHistoryPage> {
  List _pesanan = [];

  void _getPesanan() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/pesanan/riwayat');
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
          'Riwayat Pesanan',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: _pesanan.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => PenggunaHistoryPage()));
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Berat'),
                            Text(
                              _pesanan[index]['berat'].toString() + ' kg',
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
                            Text('Total Harga'),
                            Text(
                              'Rp ' + _pesanan[index]['harga'].toString(),
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
                            Text('Status'),
                            Text(
                              _pesanan[index]['status'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
