import 'package:countwindowsapp/Screens/counterPage.dart';
import 'package:countwindowsapp/Screens/detailCountPage.dart';
import 'package:countwindowsapp/models/counters/counter.dart';
import 'package:countwindowsapp/models/counters/counter_bloc_provider.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final String apiKey;
  final String keyValue;
  final String image;
  final int value;
  final int counterId;
  final int projectId;
  CounterWidget(
      {this.apiKey,
      this.keyValue,
      this.value,
      this.counterId,
      this.projectId,
      this.image});
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  GetCounterBloc getCounterBloc;
  Counter counter;
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(widget.counterId.toString()),
        onDismissed: (direction) => null,
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
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailCountPage(
                            apiKey: widget.apiKey,
                            image: widget.image,
                          )));
            },
            child: Container(
                key: Key(widget.keyValue),
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
                child: Column(
                  children: <Widget>[
                    Text('${widget.value}'),
                    Text('Counter Id:' + widget.counterId.toString()),
                    Text('Project Id:' + widget.projectId.toString()),

                  ],
                ))));
  }
}
