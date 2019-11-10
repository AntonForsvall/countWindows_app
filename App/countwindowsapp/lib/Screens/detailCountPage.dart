import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailCountPage extends StatefulWidget {
  final String apiKey;
  final String image;

  DetailCountPage({this.apiKey, this.image});

  @override
  _DetailCountPageState createState() => _DetailCountPageState();
}

class _DetailCountPageState extends State<DetailCountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xF50B1F3D),
        bottomOpacity: 0,
        elevation: 0,
        title: Text('Detail Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              size: 40,
            ),
            onPressed: () {},
            padding: EdgeInsets.only(right: 10),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xF50B1F3D),
              child: Image.asset(''),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.center,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                color: Color(0xF50B1F3D),
                child: Text('0',
                    style: TextStyle(fontSize: 80.0, color: Colors.white),
                    textAlign: TextAlign.center),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
