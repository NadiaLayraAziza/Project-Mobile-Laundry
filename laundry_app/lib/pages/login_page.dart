import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/home_page.dart';
import 'package:laundry_app/pages/penyedia_home_page.dart';
import 'package:laundry_app/pages/register_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:laundry_app/widgets/bottom_feedback.dart';
import 'package:laundry_app/widgets/bottom_feedback.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _handleSubmit() async {
    try {
      var url = Uri.parse(StringConstant.BASEURL + '/login');
      var response = await http.post(url, body: {
        'email': email.text,
        'password': password.text,
      });
      if (response.statusCode == 200) {
        BottomFeedback.success(context, 'Selamat', 'Login berhasil');
        var res = json.decode(response.body)['data'];
        StringConstant.setToken(res['token']['access_token']);
        StringConstant.setRole(res['user']['role']);
        if (res['user']['role'] == 'pengguna') {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => PenyediaHomePage()));
        }
      } else {
        BottomFeedback.error(context, 'Error', 'Login gagal 😑');
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'lib/images/accent.png',
                    width: 99,
                    height: 4,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Login to your account',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: password,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: heading6.copyWith(color: textGrey),
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Material(
                borderRadius: BorderRadius.circular(14.0),
                elevation: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          BottomFeedback.error(context, 'Mohon maaf!',
                              'Pastikan semua data terisi!');
                        } else {
                          _handleSubmit();
                        }
                      },
                      borderRadius: BorderRadius.circular(14.0),
                      child: Center(
                        child: Text(
                          'Login',
                          style: heading5.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun? ",
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
