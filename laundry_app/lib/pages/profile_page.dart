import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/theme.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                imageUrl: "https://drukasia.com/images/stripes/monk3.jpg",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Color(0xFFEBEBF4),
                  highlightColor: Color(0xFFEBEBF4),
                  child: Container(
                    color: primaryBlue,
                    width: double.infinity,
                    height: 100,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(height: 15),
              Text('Tita',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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
                        'Tita',
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
                        '012312312',
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
                        'Tita@gmail.com',
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
                        'asdasdas',
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
