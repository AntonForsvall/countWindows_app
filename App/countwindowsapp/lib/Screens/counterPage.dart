import 'package:countwindowsapp/Screens/addWindowPage.dart';
import 'package:countwindowsapp/Screens/projectPage.dart';
import 'package:countwindowsapp/UI/widgets/counterWidget.dart';
import 'package:countwindowsapp/UI/widgets/projectWidget.dart';
import 'package:countwindowsapp/models/counters/counter_bloc_provider.dart';
import 'package:countwindowsapp/models/counters/counter.dart';
import 'package:countwindowsapp/models/projects/project_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CounterPage extends StatefulWidget {
  final String apiKey;
  final int projectId;
  final String projectName;
  CounterPage(
      {Key key, this.apiKey, @required this.projectId, this.projectName})
      : super(key: key);
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  List<Counter> counterList = [];
  GetCounterBloc getCounterBloc;
  @override
  void initState() {
    super.initState();
    getCounterBloc = GetCounterBloc(widget.apiKey, widget.projectId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.projectName}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xF50B1F3D),
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xF50B1F3D),
        child: StreamBuilder(
          stream: getCounterBloc.getCounters,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddWindowPage(
                        apiKey: widget.apiKey,
                        projectId: widget.projectId,
                      )));
        },
        backgroundColor: Color(0xF88ACEA1),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, Counter item) {
    return ListTile(
      key: Key(item.id.toString()),
      title: CounterWidget(
          value: item.value, counterId: item.id, projectId: widget.projectId),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Counter> counterList) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
        // handleSide: ReorderableListSimpleSide.Right,
        // handleIcon: Icon(Icons.access_alarm),
        padding: EdgeInsets.only(top: 50),
        children: counterList
            .map((Counter item) => _buildListTile(context, item))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            Counter item = counterList[oldIndex];
            counterList.remove(item);
            counterList.insert(newIndex, item);
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
        Text('No Counter is yet created!', style: TextStyle(color: Colors.white, fontSize: 20),),
        SizedBox(height: 10),
        Text('Hit the green button to create your Counters...', style: TextStyle(color: Colors.white, fontSize: 15),),
      ],
    ));
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Counter item = counterList.removeAt(oldIndex);
      counterList.insert(newIndex, item);
    });
  }
}
