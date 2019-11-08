import 'package:countwindowsapp/Screens/counterPage.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProjectWidget extends StatelessWidget {
  final String projectName;
  final int projectId;
  final String keyValue;
  final String apiKey;

  ProjectWidget({this.projectName, this.keyValue, this.projectId, this.apiKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CounterPage(projectId: projectId, apiKey: apiKey,)));
    }, child: Container(
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
              Text(projectName),
              Text(projectId.toString()),
            ],
          )
    ));
  }
}