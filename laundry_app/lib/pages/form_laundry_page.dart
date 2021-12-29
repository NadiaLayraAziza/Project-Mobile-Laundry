import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/theme.dart';
import 'package:laundry_app/widgets/bottom_feedback.dart';

class FormLaundryPage extends StatefulWidget {
  const FormLaundryPage({Key? key}) : super(key: key);

  @override
  _FormLaundryPageState createState() => _FormLaundryPageState();
}

class _FormLaundryPageState extends State<FormLaundryPage> {
  TextEditingController _tanggal = TextEditingController();
  TextEditingController _estimasi = TextEditingController();
  TextEditingController _pengambilan = TextEditingController();
  String status = '';
  final _formKey = GlobalKey<FormState>();

  void _handleRadioValueChange(String? value) {
    setState(() {
      status = value!;

      switch (status) {
        case 'pengguna':
          break;
        case 'penyedia':
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Pesanan',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    controller: _tanggal,
                    decoration: new InputDecoration(
                      labelText: "Tanggal",
                      labelStyle: TextStyle(color: primaryBlue),
                      focusColor: primaryBlue,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: primaryBlue)),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: primaryBlue)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextFormField(
                    controller: _tanggal,
                    decoration: new InputDecoration(
                      labelText: "Estimasi Hari",
                      labelStyle: TextStyle(color: primaryBlue),
                      focusColor: primaryBlue,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: primaryBlue)),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: primaryBlue)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Estimasi hari tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 'diantar',
                      groupValue: status,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text(
                      'Diantar',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                      value: 'dijemput',
                      groupValue: status,
                      onChanged: _handleRadioValueChange,
                    ),
                    Text(
                      'Dijemput',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (status.isEmpty) {
                              BottomFeedback.error(
                                  context, 'Mohon maaf', 'Lengkapi semua data');
                            } else {
                              // _submit();
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryBlue)),
                        child: Text('Pesan Sekarang'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
