import 'package:countwindowsapp/Screens/detailCountPage.dart';
import 'package:countwindowsapp/models/counters/counter.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final String apiKey;
  final Key key;
  final Counter counter;
  final ValueChanged<Counter> onIncrement;
  final ValueChanged<Counter> onDecrement;
  final ValueChanged<Counter> onDissmissed;
  
  CounterWidget({
    this.apiKey,
    this.key,
    this.counter,
    this.onIncrement,
    this.onDecrement,
    this.onDissmissed,
  });

  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        key: key,
        onDismissed: (direction) => onDissmissed(counter),
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
                            apiKey: apiKey,
                            image: counter.image,
                          )));
            },
            child: Container(
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
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: new Container(
                      child: Image(
                        image: new AssetImage(counter.image),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),
                      width: 140,
                    ),
                  ),
                  Container(
                    child: new OutlineButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        onPressed: () => onIncrement(counter),
                        shape: new CircleBorder()),
                    alignment: Alignment.center,
                    width: 70,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: new Text(
                        '${counter.value}',
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                      ),
                      alignment: Alignment.center,
                      width: 70,
                    ),
                  ),
                  Container(
                    child: new OutlineButton(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        onPressed: () => onDecrement(counter),
                        shape: new CircleBorder()),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 5.0),
                    width: 70,
                  ),
                ],
              ),
            )));
  }
}
