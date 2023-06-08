// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTask;
  final List<Task> completedTask;
  final List<Task> favoriteTask;
  final List<Task> removedTasks;
  const TasksState({
    this.pendingTask = const <Task>[],
    this.completedTask = const <Task>[],
    this.favoriteTask = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  @override
  List<Object> get props =>
      [pendingTask, completedTask, favoriteTask, removedTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTask': pendingTask.map((x) => x.toMap()).toList(),
      'completedTask': completedTask.map((x) => x.toMap()).toList(),
      'favoriteTask': favoriteTask.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTask:
          List<Task>.from(map['pendingTask']?.map((x) => Task.fromMap(x))),
      /* List<Task>.from(
        (map['pendingTask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ), */
      completedTask:
          List<Task>.from(map['completedTask']?.map((x) => Task.fromMap(x))),
      /* List<Task>.from(
        (map['completedTask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ), */
      favoriteTask:
          List<Task>.from(map['favoriteTask']?.map((x) => Task.fromMap(x))),
      /* List<Task>.from(
        (map['favoriteTask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ), */
      removedTasks:
          List<Task>.from(map['removedTasks']?.map((x) => Task.fromMap(x))),
      /* List<Task>.from(
        (map['removedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ), */
    );
  }
}
