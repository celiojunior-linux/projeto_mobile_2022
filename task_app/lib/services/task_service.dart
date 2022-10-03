import 'package:task_app/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/models/task.dart';
import 'package:task_app/services/user_service.dart';
import 'dart:convert';

import 'package:task_app/store/ducks/auth.dart';

class TaskService {
  final Uri url = Uri.http(Api.baseUrl, Api.tasksEndpoint);

  Future<List<Task>> getTasks() async {
    Map<String, String>? headers = await AuthDucks().getAuthenticationHeaders();
    http.Response response = await http.get(url, headers: headers);
    List<dynamic> data = json.decode(response.body);
    List<Task> tasks = [];
    for (var json in data) {
      tasks.add(Task.fromJson(json));
    }
    return tasks;
  }

  Future<bool> createTask(String description) async {
    Map<String, String>? headers = await AuthDucks().getAuthenticationHeaders();
    Map<String, dynamic>? userData = await UserService().getCurrentUserInfo();
    http.Response response = await http.post(url, headers: headers, body: {
      'description': description,
      'author': userData!['id'].toString(),
    });
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      return Future.error('Descrição inválida');
    }
    return false;
  }

  Future<bool> deleteTask(int? id) async{
    Map<String, String>? headers = await AuthDucks().getAuthenticationHeaders();
    Uri taskDeleteUrl = Uri.http(Api.baseUrl, '${Api.tasksEndpoint}$id');
    http.Response response = await http.delete(taskDeleteUrl, headers: headers);
    if (response.statusCode == 204){
      return true;
    }
    return false;
  }

  Future<bool> updateTaskStatus(int? id, Task task) async {
    Map<String, String>? headers = await AuthDucks().getAuthenticationHeaders();
    Uri taskDeleteUrl = Uri.http(Api.baseUrl, '${Api.tasksEndpoint}$id/');
    http.Response response = await http.put(taskDeleteUrl, headers: headers, body: task.toJson());
    if (response.statusCode == 204){
      return true;
    }
    return false;
  }
}
