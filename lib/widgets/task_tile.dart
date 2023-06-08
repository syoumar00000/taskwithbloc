import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';
import 'popup_menu.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  void _removeOrDeleteTasks(BuildContext ctx, Task task) {
    task.isDeleted!
        ? {
            ctx.read<TasksBloc>().add(DeleteTask(task: task)),
            ctx.read<TasksBloc>().add(GetAllTask()),
          }
        : {
            ctx.read<TasksBloc>().add(RemoveTask(task: task)),
            ctx.read<TasksBloc>().add(GetAllTask())
          };
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(
                  oldTask: widget.task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                widget.task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: widget.task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hms()
                            .format(DateTime.parse(widget.task.date)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: widget.task.isDone,
                onChanged: widget.task.isDeleted == false
                    ? (value) => {
                          context
                              .read<TasksBloc>()
                              .add(UpdateTask(task: widget.task)),
                          context.read<TasksBloc>().add(GetAllTask()),
                        }
                    : null,
              ),
              PopupMenu(
                  task: widget.task,
                  likeOrDisLikeCallback: () => {
                        context.read<TasksBloc>().add(
                            MarkFavoriteOrUnfavoriteTask(task: widget.task)),
                        context.read<TasksBloc>().add(GetAllTask())
                      },
                  cancelOrDeleteCallBack: () =>
                      _removeOrDeleteTasks(context, widget.task),
                  editTaskCallback: () {
                    _editTask(context);
                    Navigator.of(context).pop();
                  },
                  restoreTaskCallback: () => {
                        context
                            .read<TasksBloc>()
                            .add(RestoreTask(task: widget.task)),
                        context.read<TasksBloc>().add(GetAllTask()),
                      }),
            ],
          ),
        ],
      ),
    );
  }
}



/* ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: task.isDeleted == false
            ? (value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              }
            : null,
      ),
      onLongPress: () => _removeOrDeleteTasks(context, task),
    ); */