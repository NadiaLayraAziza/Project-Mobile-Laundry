import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Home",
    home: new HalHome(),
  ));
} 

class HalHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(
        padding: EdgeInsets.all(20),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Card(
              child: new Column(children: <Widget>[
                new Icon(
                  Icons.home,
                  size: 100.0,
                  color: Colors.brown,
                ),
                new Text(
                  "Laundry Claudia",
                  style: new TextStyle(),
                ),
              ]),
            ),
            new Card(
              child: new Column(children: <Widget>[
                new Icon(
                  Icons.home,
                  size: 100.0,
                  color: Colors.brown,
                ),
                new Text(
                  "Laundry Salsabilla",
                  style: new TextStyle(),
                ),
              ]),
            ),
            new Card(
              child: new Column(children: <Widget>[
                new Icon(
                  Icons.home,
                  size: 100.0,
                  color: Colors.brown,
                ),
                new Text(
                  "Laundry Everyday",
                  style: new TextStyle(),
                ),
              ]),
            ),
            new Card(
              child: new Column(children: <Widget>[
                new Icon(
                  Icons.home,
                  size: 100.0,
                  color: Colors.brown,
                ),
                new Text(
                  "Laundry Purna Jaya",
                  style: new TextStyle(),
                ),
              ]),
            ),
            new Card(
              child: new Column(children: <Widget>[
                new Icon(
                  Icons.home,
                  size: 100.0,
                  color: Colors.brown,
                ),
                new Text(
                  "Laundry Kembang",
                  style: new TextStyle(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
