import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final String? searchQuery;
  final String? filterTag;
  final bool showCompletedOnly;

  const TaskLoaded({
    required this.tasks,
    this.searchQuery,
    this.filterTag,
    this.showCompletedOnly = false,
  });

  List<Task> get filteredTasks {
    var filtered = tasks;

    if (showCompletedOnly) {
      filtered = filtered.where((task) => task.isCompleted).toList();
    }

    if (filterTag != null && filterTag!.isNotEmpty) {
      filtered = filtered.where((task) => task.tag == filterTag).toList();
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      filtered = filtered.where((task) {
        return task.title.toLowerCase().contains(searchQuery!.toLowerCase()) ||
            task.description.toLowerCase().contains(searchQuery!.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  int get completedCount => tasks.where((task) => task.isCompleted).length;
  int get totalCount => tasks.length;
  double get completionPercentage =>
      totalCount > 0 ? (completedCount / totalCount) * 100 : 0;

  @override
  List<Object?> get props => [tasks, searchQuery, filterTag, showCompletedOnly];

  TaskLoaded copyWith({
    List<Task>? tasks,
    String? searchQuery,
    String? filterTag,
    bool? showCompletedOnly,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      searchQuery: searchQuery ?? this.searchQuery,
      filterTag: filterTag ?? this.filterTag,
      showCompletedOnly: showCompletedOnly ?? this.showCompletedOnly,
    );
  }
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}

class TaskOperationSuccess extends TaskState {
  final String message;

  const TaskOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}
