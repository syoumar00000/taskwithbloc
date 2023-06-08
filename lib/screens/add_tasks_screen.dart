import 'package:flutter/material.dart';
import 'package:tdapp/services/guid_gen.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'add task',
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
                    var task = Task(
                        date: DateTime.now().toString(),
                        title: titleController.text,
                        description: descriptionController.text,
                        id: GUIDGen.generate());

                    context.read<TasksBloc>().add(AddTask(task: task));
                    context.read<TasksBloc>().add(GetAllTask());
                    Navigator.pop(context);
                  },
                  child: const Text('add')),
            ],
          ),
        ],
      ),
    );
  }
}
