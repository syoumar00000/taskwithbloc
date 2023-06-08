import 'package:flutter/material.dart';
import 'package:tdapp/models/task.dart';
import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatefulWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);
  static const id = 'pending_tasks_screen';

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTask;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${tasksList.length} Pending | ${state.completedTask.length} Completed',
                ),
              ),
            ),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
