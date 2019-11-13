import 'package:flutter/material.dart';

typedef Widget ItemWidgetBuilder<T>(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  ListItemsBuilder({this.items, this.itemBuilder});
  final List<T> items;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      if (items.length > 0) {
        return _buildList();
      } else {
        return _noDataWidget(context);
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, items[index]);
        });
  }
}

Widget _noDataWidget(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'No Counter is yet created!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          'Hit the green button to create your Counters...',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    ));
  }