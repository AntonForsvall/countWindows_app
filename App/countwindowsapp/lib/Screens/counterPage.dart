import 'dart:async';

import 'package:countwindowsapp/Screens/addWindowPage.dart';
import 'package:countwindowsapp/UI/widgets/counterWidget.dart';
import 'package:countwindowsapp/UI/widgets/listItemBuilder.dart';
import 'package:countwindowsapp/models/counters/counter_bloc_provider.dart';
import 'package:countwindowsapp/models/counters/counter.dart';
import 'package:countwindowsapp/models/resources/repository.dart';
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
  //List<Counter> counterList = [];
  //GetCounterBloc getCounterBloc;
    final _repository = Repository();
  StreamController<List<Counter>> counterController;

   loadCounters(String apiKey, int projectId) async {
    _repository.getUserCounters(apiKey, projectId).then((res) async {
      counterController.add(res);
      return res;
    });
  }

  Future <Null> _handleRefresh(String apiKey, int projectId) async {
    loadCounters(apiKey, projectId).then((res) async {
      counterController.add(res);
      return null;
    });
  }

  Stream<List<Counter>> get getCounters => counterController.stream;
  @override
  void initState() {
    counterController = new StreamController<List<Counter>>();
    loadCounters(widget.apiKey, widget.projectId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _increment(Counter counter) async {
    counter.value++;
    await counterBloc.updateCounter(counter.id, counter.value, widget.apiKey);
    _handleRefresh(widget.apiKey, counter.projectId);
  }

  void _decrement(Counter counter) async {
    counter.value--;
    await counterBloc.updateCounter(counter.id, counter.value, widget.apiKey);
    _handleRefresh(widget.apiKey, counter.projectId);
  }

  void _delete(Counter counter) async {

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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildContent(),
        ),
      //   StreamBuilder<List<Counter>>(
      //     stream: getCounterBloc.getCounters,
      //     initialData: [],
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData && snapshot != null) {
      //         if (snapshot.data.length > 0) {
      //           return _buildReorderableListSimple(context, snapshot.data);
      //         } 
      //       } else if (snapshot.hasError) {
      //         return Container();
      //       }
      //       print(snapshot.data);
      //       return _noDataWidget(context);
      //     },
      //   ),
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

    Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: StreamBuilder(
        stream: getCounters,
        builder: (context, snapshot) {
          return ListItemsBuilder<Counter>(
            items: snapshot.hasData ? snapshot.data : null,
            itemBuilder: (context, counter) {
              return CounterWidget(
          apiKey: widget.apiKey,
            counter: counter, key: Key('counter-${counter.id}'),onIncrement: _increment, onDecrement: _decrement , onDissmissed: _delete);
            },
          );
        },
      ),
    );
  }


  // Widget _buildListTile(BuildContext context, Counter counter) {
  //   return ListTile(
  //     key: Key(counter.id.toString()),
  //     title: CounterWidget(
  //       apiKey: widget.apiKey,
  //         counter: counter, key: Key('counter-${counter.id}'),onIncrement: _increment, onDecrement: _decrement , onDissmissed: _delete),
  //   );
  // }

//   Widget _buildReorderableListSimple(
//       BuildContext context, List<Counter> counterList) {
//     return Theme(
//       data: ThemeData(canvasColor: Colors.transparent),
//       child: ReorderableListView(
//         // handleSide: ReorderableListSimpleSide.Right,
//         // handleIcon: Icon(Icons.access_alarm),
//         padding: EdgeInsets.only(top: 50),
//         children: counterList
//             .map((Counter item) => _buildListTile(context, item))
//             .toList(),
//         onReorder: (oldIndex, newIndex) {
//           setState(() {
//             Counter item = counterList[oldIndex];
//             counterList.remove(item);
//             counterList.insert(newIndex, item);
//           });
//         },
//       ),
//     );
//   }

  

//   void onReorder(int oldIndex, int newIndex) {
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//       final Counter item = counterList.removeAt(oldIndex);
//       counterList.insert(newIndex, item);
//     });
//   }
}
