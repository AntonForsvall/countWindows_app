



import 'package:countwindowsapp/Screens/counterPage.dart';
import 'package:countwindowsapp/models/counters/counter.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final String apiKey;
  final String keyValue;
  final int value;
  final int counterId;
  final int projectId;
  CounterWidget({this.apiKey, this.keyValue, this.value, this.counterId, this.projectId});
  @override

  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
    Counter counter;
    Widget build(BuildContext context) {
    return GestureDetector( onTap: (){
      
    }, child: Container(
      key: Key(widget.keyValue),
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
              Text('${widget.value}'),
              Text('Counter Id:' + widget.counterId.toString()),
              Text('Project Id:' + widget.projectId.toString())
            ],
          )
    ));
  }
}