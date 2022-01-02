import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/form_laundry_page.dart';
import 'package:laundry_app/pages/home_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;

class KategoriPage extends StatefulWidget {
  final String id;
  const KategoriPage({Key? key, required this.id}) : super(key: key);

  @override
  _KategoriPageState createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  List kategori = [];
  String name = '';

  void _getKategori() async {
    try {
      var url = Uri.parse(
          StringConstant.BASEURL + '/kategori?laundry_id=' + widget.id);
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + StringConstant.token},
      );
      if (response.statusCode == 200) {
        setState(() {
          kategori = json.decode(response.body)['data'];
          name = kategori.elementAt(0)['laundry']['nama_laundry'];
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
            name,
            style: heading2.copyWith(color: Colors.white),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
            child: Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: kategori.map((e) {
                return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FormLaundryPage(
                                    laundryId: e['laundry_id'].toString(),
                                    kategoriId: e['id'].toString(),
                                  )));
                    },
                    child: Card(
                      color: Colors.grey[200],
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_laundry_service,
                              size: 60,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              e['jenis'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              e['hargakg'].toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
