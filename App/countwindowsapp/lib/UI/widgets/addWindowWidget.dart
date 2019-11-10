


import 'package:countwindowsapp/models/counters/counter_bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddWindowsWidget extends StatefulWidget {
  final int index;
  final String windowImage;
  final String apiKey;
  final int projectId;
  AddWindowsWidget({this.index, this.windowImage, this.apiKey, this.projectId});

  @override
  _AddWindowsWidgetState createState() => _AddWindowsWidgetState();
}

class _AddWindowsWidgetState extends State <AddWindowsWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: widget.index,
        child: Material(
          child: InkWell(
            onTap: () {
              counterBloc.saveCounter(widget.windowImage, 0, 'test', widget.apiKey, widget.projectId);
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                color: Color(0xF50B1F3D),
                child: Image.asset(
                  widget.windowImage,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}