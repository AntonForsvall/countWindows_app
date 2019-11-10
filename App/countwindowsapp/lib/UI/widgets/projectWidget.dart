import 'package:countwindowsapp/Screens/counterPage.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:countwindowsapp/models/projects/project_bloc_provider.dart';
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
    return Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(projectId.toString()),
        onDismissed: (direction) =>
          deleteProjectBloc.deleteProject(apiKey, projectId),
        background: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white70,
          ),
          decoration: BoxDecoration(color: Colors.red[300]),
        ),
        confirmDismiss: (direction) {
          return showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Delete?'),
                  content: Text('Are you really want to delete'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Confirm'),
                      onPressed: () => Navigator.of(context).pop(true),
                    )
                  ],
                );
              });
        },
        child: new GestureDetector( onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CounterPage(projectId: projectId, apiKey: apiKey, projectName: projectName,)));
    }, child: Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white70,
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
              Text(projectName, style: TextStyle(color: Color(0xF50B1F3D),),),
              Text(projectId.toString(), style: TextStyle(color: Color(0xF50B1F3D),)),
            ],
          )
    )));
  }
}