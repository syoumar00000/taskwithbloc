import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({super.key, required this.oldTask});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Edit task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                  label: Text('title'), border: OutlineInputBorder()),
            ),
          ),
          TextField(
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            controller: descriptionController,
            decoration: const InputDecoration(
                label: Text('description'), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: () {
                    var editedTask = Task(
                        date: DateTime.now().toString(),
                        title: titleController.text,
                        description: descriptionController.text,
                        isFavorite: oldTask.isFavorite,
                        isDone: false,
                        id: oldTask.id);

                    context.read<TasksBloc>().add(EditTask(
                        // oldTask: oldTask,
                        newTask: editedTask));
                    context.read<TasksBloc>().add(GetAllTask());
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }
}
