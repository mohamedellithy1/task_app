import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/constants.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> saveTasks(List<TaskModel> tasks);
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.tasksKey);
      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load tasks from cache');
    }
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    try {
      final jsonList = tasks.map((task) => task.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(AppConstants.tasksKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save tasks to cache');
    }
  }

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final tasks = await getTasks();
      tasks.add(task);
      await saveTasks(tasks);
      return task;
    } catch (e) {
      throw Exception('Failed to add task');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final tasks = await getTasks();
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
        await saveTasks(tasks);
        return task;
      } else {
        throw Exception('Task not found');
      }
    } catch (e) {
      throw Exception('Failed to update task');
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      final tasks = await getTasks();
      tasks.removeWhere((task) => task.id == taskId);
      await saveTasks(tasks);
    } catch (e) {
      throw Exception('Failed to delete task');
    }
  }
}
