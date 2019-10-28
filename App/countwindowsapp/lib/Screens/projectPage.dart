// import the Flutter sdk
import 'package:flutter/material.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';
import 'package:countwindowsapp/models/users/user.dart';
import 'package:countwindowsapp/models/resources/api.dart';
import 'package:countwindowsapp/models/projects/project.dart';

class ProjectPage extends StatelessWidget{
@override
Widget build(BuildContext context) {
    return Scaffold(
      body: projectWidget() );
  }

}
 var api = ApiProvider();

Widget projectWidget(){
  return FutureBuilder<Project>(future: api.getProject(),builder: (context, projectSnap){
    if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
  }
  return Text('${projectSnap.data.projectName}');
  });
}

Widget buildProjectsTile(BuildContext context, Project project){
  return ListTile(
    key: Key(project.id.toString()),
    title: ProjectWidget()
  );
}

class ProjectWidget extends StatelessWidget{
  final String title;
  final String keyValue;
  ProjectWidget({this.title, this.keyValue});
  @override
  Widget build(BuildContext context){
    return Container(
      key: Key(keyValue),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[600],
      ),
    child: Row(
      children: <Widget>[
        Text(title)
      ],
    ),
    );
  }
}