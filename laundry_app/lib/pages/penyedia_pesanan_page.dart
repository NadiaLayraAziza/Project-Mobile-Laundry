import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/theme.dart';

class PenyediaPesananPage extends StatefulWidget {
  const PenyediaPesananPage({Key? key}) : super(key: key);

  @override
  _PenyediaPesananPageState createState() => _PenyediaPesananPageState();
}

class _PenyediaPesananPageState extends State<PenyediaPesananPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan',
          style: heading2.copyWith(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => PenyediaHistoryPage()));
                },
                child: Card(
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nama pengguna'),
                            Text(
                              'Tita',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nama kategori'),
                            Text(
                              'Cuci basah',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tanggal'),
                            Text(
                              '2021-10-11',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _showModalUpdate();
                            },
                            child: Text('Update'))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _showModalUpdate() async {
    TextEditingController _harga = TextEditingController();
    TextEditingController _berat = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Pesanan'),
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
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _berat,
                        decoration: new InputDecoration(
                          labelText: "Berat (kg)",
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
                            return 'Berat tidak boleh kosong';
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
