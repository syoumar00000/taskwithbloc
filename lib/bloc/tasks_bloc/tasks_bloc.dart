/* import 'package:equatable/equatable.dart';
import 'package:tdapp/models/task.dart';

import '../../blocs/bloc_exports.dart';

//part 'tasks_event.dart';
//part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTask: List.from(state.allTask)..add(event.task),
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTask.indexOf(task);
    List<Task> allTasks = List.from(state.allTask)..remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));
    emit(TasksState(allTask: allTasks, removedTasks: state.removedTasks));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTask: List.from(state.allTask)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
      ),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          allTask: state.allTask,
          removedTasks: List.from(state.removedTasks)..remove(event.task)),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
 */