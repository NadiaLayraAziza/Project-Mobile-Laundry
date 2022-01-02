import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/form_laundry.dart';
import 'package:laundry_app/pages/home_page.dart';
import 'package:laundry_app/pages/penyedia_home_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:laundry_app/widgets/bottom_feedback.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  void initState() {
    super.initState();
    _getProfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
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
        actions: [
          profil['role'] == 'penyedia'
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FormLaundry(
                                  data: profil['laundry'] == null
                                      ? {}
                                      : profil['laundry'],
                                )));
                  },
                  icon: Icon(Icons.local_laundry_service_outlined))
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              profil['role'] == 'penyedia'
                  ? profil['laundry'] == null
                      ? CachedNetworkImage(
                          width: double.infinity,
                          imageUrl:
                              "https://drukasia.com/images/stripes/monk3.jpg",
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFEBEBF4),
                            child: Container(
                              color: primaryBlue,
                              width: double.infinity,
                              height: 100,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : profil['laundry']['gambar'] == ""
                          ? CachedNetworkImage(
                              width: double.infinity,
                              imageUrl:
                                  "https://drukasia.com/images/stripes/monk3.jpg",
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Color(0xFFEBEBF4),
                                highlightColor: Color(0xFFEBEBF4),
                                child: Container(
                                  color: primaryBlue,
                                  width: double.infinity,
                                  height: 100,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : CachedNetworkImage(
                              width: double.infinity,
                              imageUrl: profil['laundry']['gambar'],
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Color(0xFFEBEBF4),
                                highlightColor: Color(0xFFEBEBF4),
                                child: Container(
                                  color: primaryBlue,
                                  width: double.infinity,
                                  height: 100,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                  : Container(),
              SizedBox(height: 15),
              profil['role'] == 'penyedia'
                  ? Text(
                      profil['laundry'] == null
                          ? '...'
                          : profil['laundry']['nama_laundry'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
                  : Container(),
              SizedBox(height: 15),
              Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nama'),
                      Text(
                        profil['nama'].toString().isNotEmpty
                            ? profil['nama'].toString()
                            : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nomor HP'),
                      Text(
                        profil['telepon'].toString().isNotEmpty
                            ? profil['telepon'].toString()
                            : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email'),
                      Text(
                        profil['email'].toString().isNotEmpty
                            ? profil['email'].toString()
                            : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Alamat'),
                      Text(
                        profil['alamat'].toString().isNotEmpty
                            ? profil['alamat'].toString()
                            : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
