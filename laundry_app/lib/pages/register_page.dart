import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/login_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:laundry_app/widgets/bottom_feedback.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  String role = '';
  String nama = '';
  String username = '';
  String alamat = '';
  String email = '';
  String password = '';
  String telepon = '';

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      role = value!;

      switch (role) {
        case 'pengguna':
          break;
        case 'penyedia':
          break;
      }
    });
  }

  void _handleSubmit() async {
    try {
      Map payload = {
        'role': role.toString(),
        'nama': nama.toString(),
        'email': email.toString(),
        'username': username.toString(),
        'alamat': alamat.toString(),
        'password': password.toString(),
        'telepon': telepon.toString(),
      };
      var url = Uri.parse(StringConstant.BASEURL + '/register');
      var response = await http.post(url, body: payload);
      if (response.statusCode == 200) {
        BottomFeedback.success(context, 'Selamat', 'Registrasi berhasil');
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginPage()));
        });
      } else {
        print(response.body);
        // BottomFeedback.error(context, 'Error', '${response.body}');
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
      body: SingleChildScrollView(
        child: SafeArea(
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
                      'Register account',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 'penyedia',
                            groupValue: role,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text(
                            'Penyedia',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Radio(
                            value: 'pengguna',
                            groupValue: role,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text(
                            'Pengguna',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              nama = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Nama Lengkap',
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
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Username',
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
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
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
                          onChanged: (value) {
                            setState(() {
                              telepon = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Nomor HP',
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
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          onChanged: (value) {
                            setState(() {
                              alamat = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Alamat',
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
                          obscureText: !passwordVisible,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
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
                          print('tap');
                          if (nama.isEmpty ||
                              email.isEmpty ||
                              username.isEmpty ||
                              password.isEmpty ||
                              alamat.isEmpty ||
                              role.isEmpty ||
                              telepon.isEmpty) {
                            BottomFeedback.error(context, 'Mohon maaf!',
                                'Pastikan semua data terisi!');
                          } else {
                            _handleSubmit();
                            // BottomFeedback.success(
                            //     context, 'Selamat!', 'Registrasi berhasil!');
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Register',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Login',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
