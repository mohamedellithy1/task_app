import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/toggle_task_completion.dart';
import '../../domain/usecases/update_task.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final ToggleTaskCompletion toggleTaskCompletion;

  TaskCubit({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.toggleTaskCompletion,
  }) : super(TaskInitial());

  Future<void> loadTasks() async {
    emit(TaskLoading());

    final result = await getTasks(NoParams());

    result.fold((failure) => emit(TaskError(failure.message)), (tasks) {
      final sortedTasks = List<Task>.from(tasks);
      sortedTasks.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        }
        return a.deadline.compareTo(b.deadline);
      });
      emit(TaskLoaded(tasks: sortedTasks));
    });
  }

  Future<void> createTask(Task task) async {
    final result = await addTask(task);

    result.fold((failure) => emit(TaskError(failure.message)), (
      addedTask,
    ) async {
      await loadTasks();
      emit(const TaskOperationSuccess('Task added successfully!'));
      await loadTasks();
    });
  }

  Future<void> editTask(Task task) async {
    final result = await updateTask(task);

    result.fold((failure) => emit(TaskError(failure.message)), (
      updatedTask,
    ) async {
      await loadTasks();
      emit(const TaskOperationSuccess('Task updated successfully!'));
      await loadTasks();
    });
  }

  Future<void> removeTask(String taskId) async {
    final result = await deleteTask(taskId);

    result.fold((failure) => emit(TaskError(failure.message)), (_) async {
      await loadTasks();
      emit(const TaskOperationSuccess('Task deleted successfully!'));
      await loadTasks();
    });
  }

  Future<void> toggleCompletion(String taskId) async {
    final result = await toggleTaskCompletion(taskId);

    result.fold((failure) => emit(TaskError(failure.message)), (
      updatedTask,
    ) async {
      await loadTasks();
    });
  }

  void searchTasks(String query) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  void filterByTag(String? tag) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(currentState.copyWith(filterTag: tag));
    }
  }

  void toggleShowCompletedOnly() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(
        currentState.copyWith(
          showCompletedOnly: !currentState.showCompletedOnly,
        ),
      );
    }
  }

  void clearFilters() {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(TaskLoaded(tasks: currentState.tasks));
    }
  }
}
