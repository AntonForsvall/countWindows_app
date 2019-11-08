



import 'package:countwindowsapp/UI/widgets/addWindowWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddWindowPage extends StatefulWidget {
  final String apiKey;
  final int projectId;

  AddWindowPage({this.apiKey, this.projectId});

  _AddWindowPageState createState() => _AddWindowPageState();
}

class _AddWindowPageState extends State<AddWindowPage> {


  var imageList = [
  {"picture": "asserts/images/i1x2.png"},
  {"picture": "asserts/images/images@2x.png"},
  {"picture": "asserts/images/i3@2x.png"},
];

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[200],
          title: Text('Add Window'),
        ),
        body: Container(
          color: Color(0xF50B1F3D),
          child: GridView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: imageList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 15.0),
            itemBuilder: (BuildContext context, int index) {
              return AddWindowsWidget(
                windowImage: imageList[index]['picture'],
                index: index,
                apiKey: widget.apiKey,
                projectId: widget.projectId,
              );
            }),
        )
        );
  }

}