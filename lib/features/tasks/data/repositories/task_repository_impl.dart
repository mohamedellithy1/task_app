import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/error/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_drift_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDriftDataSource driftDataSource;

  TaskRepositoryImpl({required this.driftDataSource});

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final tasks = await driftDataSource.getTasks();
      return Right(tasks);
    } catch (e) {
      return Left(CacheFailure('Failed to load tasks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Task>> addTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final addedTask = await driftDataSource.addTask(taskModel);
      return Right(addedTask);
    } catch (e) {
      return Left(CacheFailure('Failed to add task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTask = await driftDataSource.updateTask(taskModel);
      return Right(updatedTask);
    } catch (e) {
      return Left(CacheFailure('Failed to update task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await driftDataSource.deleteTask(taskId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to delete task: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Task>> toggleTaskCompletion(String taskId) async {
    try {
      final tasks = await driftDataSource.getTasks();
      final taskIndex = tasks.indexWhere((task) => task.id == taskId);

      if (taskIndex == -1) {
        return Left(CacheFailure('Task not found'));
      }

      final task = tasks[taskIndex];
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      final result = await driftDataSource.updateTask(updatedTask);
      return Right(result);
    } catch (e) {
      return Left(
        CacheFailure('Failed to toggle task completion: ${e.toString()}'),
      );
    }
  }
}
