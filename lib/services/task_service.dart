import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TaskService {
  final String _baseUrl = "https://todo-app-a10ee-default-rtdb.firebaseio.com";

  Future<List<TaskModel>> fetchTasks(String userId) async {
    try {
      print("Fetching tasks for User ID: $userId");
      
      // We'll use the most direct URL first to avoid any query issues
      final String url = '$_baseUrl/tasks.json';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data == null) {
          print("No data found in Firebase.");
          return [];
        }

        if (data is Map<String, dynamic>) {
          final List<TaskModel> loadedTasks = [];
          data.forEach((id, taskData) {
            // Manual filtering to ensure we get results even if Index is not ready
            if (taskData['userId'] == userId) {
              loadedTasks.add(TaskModel.fromJson(id, taskData));
            }
          });
          print("Loaded ${loadedTasks.length} tasks for user.");
          return loadedTasks;
        } else {
          print("Unexpected data format: ${data.runtimeType}");
          return [];
        }
      } else {
        print("Firebase Request Failed: ${response.statusCode} - ${response.body}");
        throw Exception('Firebase connection failed');
      }
    } catch (e) {
      print("CRITICAL FETCH ERROR: $e");
      rethrow;
    }
  }

  Future<TaskModel> addTask(TaskModel task) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/tasks.json'),
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      return task.copyWith(id: id);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/tasks/${task.id}.json'),
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/tasks/$id.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
