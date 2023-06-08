import 'package:flutter/material.dart';
import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrDisLikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  const PopupMenu(
      {super.key,
      required this.cancelOrDeleteCallBack,
      required this.task,
      required this.likeOrDisLikeCallback,
      required this.editTaskCallback,
      required this.restoreTaskCallback});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? (context) => [
                  PopupMenuItem(
                    onTap: null,
                    child: TextButton.icon(
                        onPressed: editTaskCallback,
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit")),
                  ),
                  PopupMenuItem(
                    onTap: likeOrDisLikeCallback,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? const Text("Add to \nBookMark")
                          : const Text("Remove from \nBookmarks"),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.delete),
                        label: const Text("Delete")),
                    onTap: () => cancelOrDeleteCallBack,
                  ),
                ]
            : (context) => [
                  PopupMenuItem(
                    onTap: restoreTaskCallback,
                    child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.restore_from_trash),
                        label: const Text("Restore")),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.delete_forever),
                        label: const Text("Delete Forever")),
                    onTap: () => cancelOrDeleteCallBack,
                  ),
                ]);
  }
}
