import 'package:flutter/material.dart';
import 'task.dart';
import 'task_item.dart';


class TaskList extends StatelessWidget {
  // Builder methods rely on a set of data, such as a list.
  final List<Task> to_dos;
  TaskList(this.to_dos);

  // First, make your build method like normal.
  // Instead of returning Widgets, return a method that returns widgets.
  // Don't forget to pass in the context!
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  // A builder method almost always returns a ListView.
  // A ListView is a widget similar to Column or Row.
  // It knows whether it needs to be scrollable or not.
  // It has a constructor called builder, which it knows will
  // work with a List.

  ListView _buildList(context) {
    return ListView.builder(
      // Must have an item count equal to the number of items!
      itemCount: to_dos.length,
      // A callback that will return a widget.
      itemBuilder: (context, int) {
        // In our case, a DogCard for each doggo.
        return ListItem(to_dos[int]);
      },
    );
  }
}