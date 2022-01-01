import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/theme.dart';
import 'package:http/http.dart' as http;

class FormKategoriPage extends StatefulWidget {
  const FormKategoriPage({Key? key}) : super(key: key);

  @override
  _FormKategoriPageState createState() => _FormKategoriPageState();
}

class _FormKategoriPageState extends State<FormKategoriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Kategori Laundry',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 15),
              Card(
                color: Colors.grey[200],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cuci Basah',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            _showModal();
                          },
                          icon: Icon(Icons.edit))
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
                      Text(
                        'Cuci Kering',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            _showModal();
                          },
                          icon: Icon(Icons.edit))
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
                      Text(
                        'Setrika',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            _showModal();
                          },
                          icon: Icon(Icons.edit))
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
                      Text(
                        'Komplit',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            _showModal();
                          },
                          icon: Icon(Icons.edit))
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

  void _showModal() async {
    TextEditingController _harga = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Kategori'),
            content: Container(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _harga,
                        decoration: new InputDecoration(
                          labelText: "Harga",
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
                            return 'Harga tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // _submit();
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryBlue)),
                            child: Text('Update'))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
