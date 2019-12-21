import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:to_do_app_v2/models/todo.dart';

class ToDoList extends StatelessWidget {
  final List<ToDo> todos;
  ToDoList({Key key,this.todos}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: index % 2 == 0? Colors.greenAccent : Colors.cyan,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(todos[index].title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
              
            ],
          ), 
        ),
        onTap: (){

        },
      );
    },
    itemCount: todos.length,
    );
  }
}

class ToDoScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _ToDoScreenState();
  }
}
class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch data from database"),
      ),
      body: FutureBuilder(
        future: fetchToDos(http.Client()),
        builder: (context,snapshot){
          if(snapshot.hasError){
            print(snapshot.error);
          }
          return snapshot.hasData ? ToDoList(todos: snapshot.data): Center(child:CircularProgressIndicator());
        },
      ),
    );
  }
}