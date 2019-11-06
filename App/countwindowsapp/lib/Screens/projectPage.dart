// import the Flutter sdk
import 'package:flutter/material.dart';
import 'package:countwindowsapp/UI/widgets/projectWidget.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:countwindowsapp/models/projects/project_bloc_provider.dart';

class ProjectPage extends StatefulWidget {
  final String apiKey;
  ProjectPage({this.apiKey});
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<Project> projectList = [];
  GetProjectBloc getProjectBloc;

  @override
  void initState() {
    getProjectBloc = GetProjectBloc(widget.apiKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xF50B1F3D),
        child: StreamBuilder(
          stream: getProjectBloc.getProjects,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              if (snapshot.data.length > 0) {
                return _buildReorderableListSimple(context, snapshot.data);
              } else if (snapshot.data == 0) {
                return Center(
                  child: Text('No Data'),
                );
              }
            } else if (snapshot.hasError) {
              return Container();
            }
            print(snapshot.data);
            return CircularProgressIndicator();
          },
        ),
      );
  }

  Widget _buildListTile(BuildContext context, Project item) {
    return ListTile(
      key: Key(item.id.toString()),
      title: ProjectWidget(
        projectName: item.projectName,
      ),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Project> projectList) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
        // handleSide: ReorderableListSimpleSide.Right,
        // handleIcon: Icon(Icons.access_alarm),
        padding: EdgeInsets.only(top: 300.0),
        children: projectList
            .map((Project item) => _buildListTile(context, item))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            Project item = projectList[oldIndex];
            projectList.remove(item);
            projectList.insert(newIndex, item);
          });
        },
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Project item = projectList.removeAt(oldIndex);
      projectList.insert(newIndex, item);
    });
  }
}
