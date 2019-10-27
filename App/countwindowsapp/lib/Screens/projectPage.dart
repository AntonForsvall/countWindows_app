// import the Flutter sdk
import 'package:flutter/material.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';
import 'package:countwindowsapp/models/users/user.dart';
import 'package:countwindowsapp/models/resources/api.dart';

class ProjectPage extends StatelessWidget{
@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[200],
        title: Text('Count Windows'),
        actions: <Widget>[Icon(Icons.refresh)],
      ),
      body: null );
  }
}