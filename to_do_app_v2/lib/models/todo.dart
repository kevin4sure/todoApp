import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ToDo {
  int id;
  String title;
 

  ToDo({
    this.id,
    this.title,
    
  });

  factory ToDo.fromJson(Map<String, dynamic> json){
    return ToDo(
      id: json['id'],
      title: json['title'],
      
    );
  }
}

Future<List<ToDo>> fetchToDos(http.Client client) async {
  final response = await client.get('http://10.0.2.2:8000/to-do/');
  if(response.statusCode == 200){
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if(mapResponse['success'] == true){
      final todos = mapResponse['data'].cast<Map<String, dynamic>>();
      final listOfToDos = await todos.map<ToDo>((json){
        return ToDo.fromJson(json);
      }).toList();
      return listOfToDos;
    } else {
      return [];
    }
  }else {
    throw Exception("Falied to load ToDo from database");
  }
}