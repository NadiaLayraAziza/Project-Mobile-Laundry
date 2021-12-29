import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_app/pages/penyedia_pesanan_berlangsung_page.dart';
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
                        ElevatedButton(onPressed: () {}, child: Text('Update'))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
