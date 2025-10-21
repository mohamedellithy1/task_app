import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTask implements UseCase<Task, Task> {
  final TaskRepository repository;

  AddTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(Task task) async {
    return await repository.addTask(task);
  }
}

