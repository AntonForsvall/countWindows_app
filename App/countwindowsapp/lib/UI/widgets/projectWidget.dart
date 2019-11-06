import 'package:countwindowsapp/models/projects/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProjectWidget extends StatelessWidget {
  final String projectName;
  final String keyValue;

  ProjectWidget({this.projectName, this.keyValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          new BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10.0,
              ),
        ],
      ),
      child:
          Column(
            children: <Widget>[
              Text(projectName)
            ],
          )
    );
  }
}