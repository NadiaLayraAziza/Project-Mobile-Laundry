import 'package:flutter/material.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/home_page.dart';
import 'package:laundry_app/pages/login_page.dart';
import 'package:laundry_app/pages/penyedia_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: StringConstant.getToken(),
          builder: (context, sp) {
            if (sp.hasData) {
              StringConstant.setToken(sp.data);
              if (sp.data != '') {
                return FutureBuilder(
                    future: StringConstant.getRole(),
                    builder: (context, snapshot) {
                      // StringConstant.deleteStorage();
                      if (snapshot.hasData) {
                        if (snapshot.data == 'pengguna') {
                          return HomePage();
                        } else {
                          return PenyediaHomePage();
                        }
                      }
                      return LoginPage();
                    });
              } else {
                return LoginPage();
              }
            }
            return LoginPage();
          }),
    );
  }
}
