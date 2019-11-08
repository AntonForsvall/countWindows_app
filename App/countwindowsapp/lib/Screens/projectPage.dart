// import the Flutter sdk
import 'package:countwindowsapp/models/projects/project_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:countwindowsapp/UI/widgets/projectWidget.dart';
import 'package:countwindowsapp/models/projects/project.dart';


class ProjectPage extends StatefulWidget {
  final String apiKey;
  final int projectId;
  ProjectPage({this.apiKey, this.projectId});
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<Project> projectList = [];
  GetProjectBloc getProjectBloc;
  final _formKey = GlobalKey<FormState>();
  TextEditingController projectNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getProjectBloc = GetProjectBloc(widget.apiKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
        Scaffold(
          body: Container(
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
                return _noDataWidget(context);
              },
            ),
          ),
          floatingActionButton:  FloatingActionButton(
          child: Icon(Icons.add),
          
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Project Name'),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: projectNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(child: Text('Save', style: TextStyle(color: Colors.white),), color: Color(0xF50B1F3D),
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              projectBloc.saveProject(projectNameController.text, 'test', widget.apiKey);
                              Navigator.of(context).pop();
                            }
                          }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            );
          },
          backgroundColor: Color(0xF88ACEA1),
        ),
    );
  }

  Widget _buildListTile(BuildContext context, Project item) {
    return ListTile(
      key: Key(item.id.toString()),
      title: ProjectWidget(
        projectName: item.projectName, projectId: item.id, apiKey: widget.apiKey,
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
        padding: EdgeInsets.only(top: 50),
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

    Widget _noDataWidget(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('No Project is yet created!', style: TextStyle(color: Colors.white, fontSize: 20),),
        SizedBox(height: 10),
        Text('Hit the green button to create your Projects...', style: TextStyle(color: Colors.white, fontSize: 15),),
      ],
    ));
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
