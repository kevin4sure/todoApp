import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Task {
  final int id;
  final String title;

  Task(this.id,this.title);

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(data['id'],data['title']);
  }
}

Future<Task> fetchPost() async {
  final response = await http.get('http://10.0.2.2:8001/to-do/1/');
  print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    // var data = jsonDecode(response.body);
    // for()
    return Task.fromMap(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}