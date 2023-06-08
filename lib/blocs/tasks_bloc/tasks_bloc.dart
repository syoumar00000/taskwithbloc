import 'package:equatable/equatable.dart';
import 'package:tdapp/models/task.dart';
import '../../repository/firestore_repository.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<GetAllTask>(_onGetAllTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }
  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.create(task: event.task);
    /* final state = this.state;
    emit(
      TasksState(
        pendingTask: List.from(state.pendingTask)..add(event.task),
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
        removedTasks: state.removedTasks,
      ),
    ); */
  }

  void _onGetAllTask(GetAllTask event, Emitter<TasksState> emit) async {
    List<Task> pendingTask = [];
    List<Task> completedTask = [];
    List<Task> favoriteTask = [];
    List<Task> removedTask = [];
    await FirestoreRepository.get().then((value) {
      value.forEach((task) {
        if (task.isDeleted == true) {
          removedTask.add(task);
        } else {
          if (task.isFavorite == true) {
            favoriteTask.add(task);
          }
          if (task.isDone == true) {
            completedTask.add(task);
          } else {
            pendingTask.add(task);
          }
        }
      });
    });
    emit(TasksState(
        pendingTask: pendingTask,
        completedTask: completedTask,
        favoriteTask: favoriteTask,
        removedTasks: removedTask));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    Task updatedTask = event.task.copyWith(isDone: !event.task.isDone!);
    await FirestoreRepository.update(task: updatedTask);
    /* final state = this.state;
    final task = event.task;
    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    List<Task> favoriteTask = state.favoriteTask;
    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTask = List.from(pendingTask)..remove(task);
        completedTask.insert(0, task.copyWith(isDone: true));
      } else {
        var taskIndex = favoriteTask.indexOf(task);
        pendingTask = List.from(pendingTask)..remove(task);
        completedTask.insert(0, task.copyWith(isDone: true));
        favoriteTask = List.from(favoriteTask)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTask = List.from(completedTask)..remove(task);
        pendingTask = List.from(pendingTask)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favoriteTask.indexOf(task);
        completedTask = List.from(completedTask)..remove(task);
        pendingTask = List.from(pendingTask)
          ..insert(0, task.copyWith(isDone: false));
        favoriteTask = List.from(favoriteTask)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    } */
    /*  emit(TasksState(
        pendingTask: pendingTask,
        completedTask: completedTask,
        favoriteTask: state.favoriteTask,
        removedTasks: state.removedTasks)); */
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) async {
    Task removeddTask = event.task.copyWith(isDeleted: true);
    await FirestoreRepository.update(task: removeddTask);
    /* final state = this.state;
    emit(
      TasksState(
        pendingTask: List.from(state.pendingTask)..remove(event.task),
        completedTask: List.from(state.completedTask)..remove(event.task),
        favoriteTask: List.from(state.favoriteTask)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
      ),
    ); */
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.delete(task: event.task);

    /* final state = this.state;
    emit(
      TasksState(
          pendingTask: state.pendingTask,
          completedTask: state.completedTask,
          favoriteTask: state.favoriteTask,
          removedTasks: List.from(state.removedTasks)..remove(event.task)),
    ); */
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) async {
    Task task = event.task.copyWith(isFavorite: !event.task.isFavorite!);
    await FirestoreRepository.update(task: task);

    /* final state = this.state;
    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    List<Task> favoriteTask = state.favoriteTask;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTask = List.from(favoriteTask)
          ..insert(0, event.task.copyWith(isFavorite: true));
        //favoriteTask.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTask.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTask.indexOf(event.task);
        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTask.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTask.indexOf(event.task);
        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTask.remove(event.task);
      }
    }
    emit(TasksState(
        pendingTask: pendingTask,
        completedTask: completedTask,
        favoriteTask: favoriteTask,
        removedTasks: state.removedTasks)); */
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.update(task: event.newTask);
    /*  final state = this.state;
    List<Task> favoriteTasks = state.favoriteTask;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
      pendingTask: List.from(state.pendingTask)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTask: state.completedTask..remove(event.oldTask),
      favoriteTask: favoriteTasks,
      removedTasks: state.removedTasks,
    )); */
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) async {
    Task restoredTask = event.task.copyWith(
        isDeleted: false,
        isDone: false,
        isFavorite: false,
        date: DateTime.now().toString());
    await FirestoreRepository.update(task: restoredTask);
    /* final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTask: List.from(state.pendingTask)
          ..insert(
              0,
              event.task.copyWith(
                  isDeleted: false, isDone: false, isFavorite: false)),
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
      ),
    ); */
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.deleteAllRemovedTask(
        taskList: state.removedTasks);
    /* final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTask: state.pendingTask,
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
      ),
    ); */
  }
}
