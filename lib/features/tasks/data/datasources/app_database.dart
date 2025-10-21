import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'app_database.g.dart';

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get deadline => dateTime()();
  TextColumn get tag => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class WebAppDatabase {
  static const String _tasksKey = 'tasks_data';
  SharedPreferences? _prefs;

  Future<void> _ensurePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<List<Task>> getAllTasks() async {
    await _ensurePrefs();
    final tasksJson = _prefs!.getString(_tasksKey);
    if (tasksJson == null) return [];

    final List<dynamic> tasksList = json.decode(tasksJson);
    return tasksList.map((json) => Task.fromJson(json)).toList();
  }

  Stream<List<Task>> watchAllTasks() async* {
    yield await getAllTasks();
  }

  Future<Task?> getTaskById(String id) async {
    final tasks = await getAllTasks();
    try {
      return tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> insertTask(TasksCompanion task) async {
    await _ensurePrefs();
    final tasks = await getAllTasks();
    final newTask = Task(
      id: task.id.value,
      title: task.title.value,
      description: task.description.value,
      deadline: task.deadline.value,
      tag: task.tag.value,
      isCompleted: task.isCompleted.value,
      createdAt: task.createdAt.value,
    );
    tasks.add(newTask);
    await _saveTasks(tasks);
    return 1;
  }

  Future<bool> updateTask(TasksCompanion task) async {
    await _ensurePrefs();
    final tasks = await getAllTasks();
    final index = tasks.indexWhere((t) => t.id == task.id.value);
    if (index == -1) return false;

    tasks[index] = Task(
      id: task.id.value,
      title: task.title.value,
      description: task.description.value,
      deadline: task.deadline.value,
      tag: task.tag.value,
      isCompleted: task.isCompleted.value,
      createdAt: task.createdAt.value,
    );
    await _saveTasks(tasks);
    return true;
  }

  Future<int> deleteTask(String id) async {
    await _ensurePrefs();
    final tasks = await getAllTasks();
    final initialLength = tasks.length;
    tasks.removeWhere((task) => task.id == id);
    await _saveTasks(tasks);
    return initialLength - tasks.length;
  }

  Future<void> deleteAllTasks() async {
    await _ensurePrefs();
    await _prefs!.remove(_tasksKey);
  }

  Future<void> _saveTasks(List<Task> tasks) async {
    final tasksJson = json.encode(tasks.map((task) => task.toJson()).toList());
    await _prefs!.setString(_tasksKey, tasksJson);
  }

  Future<void> close() async {}
}

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  late final dynamic _database;
  late final bool _isWeb;

  AppDatabase() : super(_openConnection()) {
    _isWeb = kIsWeb;
    if (_isWeb) {
      _database = WebAppDatabase();
    }
  }

  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() {
    if (_isWeb) {
      return _database.getAllTasks();
    }
    return select(tasks).get();
  }

  Stream<List<Task>> watchAllTasks() {
    if (_isWeb) {
      return _database.watchAllTasks();
    }
    return select(tasks).watch();
  }

  Future<Task?> getTaskById(String id) {
    if (_isWeb) {
      return _database.getTaskById(id);
    }
    return (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertTask(TasksCompanion task) {
    if (_isWeb) {
      return _database.insertTask(task);
    }
    return into(tasks).insert(task);
  }

  Future<bool> updateTask(TasksCompanion task) {
    if (_isWeb) {
      return _database.updateTask(task);
    }
    return update(tasks).replace(task);
  }

  Future<int> deleteTask(String id) {
    if (_isWeb) {
      return _database.deleteTask(id);
    }
    return (delete(tasks)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAllTasks() {
    if (_isWeb) {
      return _database.deleteAllTasks();
    }
    return delete(tasks).go();
  }

  @override
  Future<void> close() {
    if (_isWeb) {
      return _database.close();
    }
    return super.close();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dbFolder.path, 'taskflow.sqlite');
    return SqfliteQueryExecutor.inDatabaseFolder(
      path: 'taskflow.sqlite',
      logStatements: true,
    );
  });
}
