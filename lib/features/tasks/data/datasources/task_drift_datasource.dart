import 'package:drift/drift.dart';
import '../models/task_model.dart';
import 'app_database.dart';

abstract class TaskDriftDataSource {
  Future<List<TaskModel>> getTasks();
  Stream<List<TaskModel>> watchTasks();
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
  Future<void> deleteAllTasks();
}

class TaskDriftDataSourceImpl implements TaskDriftDataSource {
  final AppDatabase database;

  TaskDriftDataSourceImpl({required this.database});

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasks = await database.getAllTasks();
      return tasks.map(_taskToModel).toList();
    } catch (e) {
      throw Exception('Failed to load tasks from database: ${e.toString()}');
    }
  }

  @override
  Stream<List<TaskModel>> watchTasks() {
    return database.watchAllTasks().map(
      (tasks) => tasks.map(_taskToModel).toList(),
    );
  }

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final companion = TasksCompanion(
        id: Value(task.id),
        title: Value(task.title),
        description: Value(task.description),
        deadline: Value(task.deadline),
        tag: Value(task.tag),
        isCompleted: Value(task.isCompleted),
        createdAt: Value(task.createdAt),
      );

      await database.insertTask(companion);
      return task;
    } catch (e) {
      throw Exception('Failed to add task: ${e.toString()}');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final companion = TasksCompanion(
        id: Value(task.id),
        title: Value(task.title),
        description: Value(task.description),
        deadline: Value(task.deadline),
        tag: Value(task.tag),
        isCompleted: Value(task.isCompleted),
        createdAt: Value(task.createdAt),
      );

      final updated = await database.updateTask(companion);
      if (!updated) {
        throw Exception('Task not found');
      }
      return task;
    } catch (e) {
      throw Exception('Failed to update task: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await database.deleteTask(taskId);
    } catch (e) {
      throw Exception('Failed to delete task: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    try {
      await database.deleteAllTasks();
    } catch (e) {
      throw Exception('Failed to delete all tasks: ${e.toString()}');
    }
  }

  TaskModel _taskToModel(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      deadline: task.deadline,
      tag: task.tag,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
    );
  }
}
