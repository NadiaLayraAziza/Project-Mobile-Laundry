import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_app/constant/string_constant.dart';
import 'package:laundry_app/pages/profile_page.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class FormLaundry extends StatefulWidget {
  final Map data;
  const FormLaundry({Key? key, required this.data}) : super(key: key);

  @override
  _FormLaundryState createState() => _FormLaundryState();
}

class _FormLaundryState extends State<FormLaundry> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nama = TextEditingController();
  String _path = '';
  String _filename = '';

  Future _submit() async {
    var end = widget.data.isEmpty
        ? '/laundry'
        : '/laundry/' + widget.data['id'].toString() + '?_method=PUT';
    var url = Uri.parse(StringConstant.BASEURL + end);
    try {
      Map<String, String> requestBody = <String, String>{
        'nama_laundry': _nama.text,
      };
      Map<String, String> headers = <String, String>{
        'contentType': 'multipart/form-data',
        'Authorization': 'Bearer ' + StringConstant.token
      };

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
      if (widget.data.isEmpty) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('gambar', _path);
        request.files.add(multipartFile);
      }
      var response = await request.send();
      var res = await http.Response.fromStream(response);
      print(url);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: json.decode(res.body)['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProfilePage()));
        });
      } else {
        Fluttertoast.showToast(
            msg: 'error',
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

  void _onChangeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _path = file.path.toString();
        _filename = file.name.toString();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      setState(() {
        _nama.text = widget.data['nama_laundry'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Profil Laundry',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nama,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan nama laundry',
                          labelText: 'Nama Laundry',
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Nama laundry tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              _onChangeFile();
                            },
                            icon: Icon(Icons.upload),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Upload Gambar'),
                                Text(_filename)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.data.isEmpty) {
                                if (_filename != '') {
                                  _submit();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Gambar harus diisi",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                _submit();
                              }
                            }
                          },
                          icon: Icon(Icons.save),
                          label: Text('Simpan'))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
