import 'package:flutter/material.dart';
import 'task.dart';


class ListItem extends StatefulWidget {
  final Task task;

  ListItem(this.task);

  @override
  _ListItemState createState() => _ListItemState(task);
}

class _ListItemState extends State<ListItem> {
  Task task;

  _ListItemState(this.task);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 100.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0.0,
              child: taskItem,
            ),
          ]
        ),
      ),
    );

//      Text(widget.task.title);
  }

  Widget get taskItem {
    return Container(
      width: 350.0,
      height: 100.0,
      child: Card(
        color: Colors.black87,
          child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 20.0,
            left: 30.0,
          ),
          child: Text(widget.task.title)
        ),
      )
    );
  }

}