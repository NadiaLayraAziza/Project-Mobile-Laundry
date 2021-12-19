import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.local_laundry_service,
              color: primaryBlue,
            ),
            Text(
              'LAUNDRY APP',
              style: heading2.copyWith(color: textBlack),
            ),
          ],
        ),
      ),
    );
  }
}
