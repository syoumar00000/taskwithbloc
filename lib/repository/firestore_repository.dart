import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../models/task.dart';

class FirestoreRepository {
  //create task
  static Future<void> create({Task? task}) async {
    try {
      await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .doc(task!.id)
          .set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get task

  static Future<List<Task>> get() async {
    List<Task> taskList = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .get();
      for (var task in data.docs) {
        taskList.add(Task.fromMap(task.data()));
      }
      return taskList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // update task
  static Future<void> update({Task? task}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));
      data.doc(task!.id).update(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //removed task
  static Future<void> remove() async {
    try {} catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete task
  static Future<void> delete({Task? task}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));
      data.doc(task!.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // favorite task
  static Future<void> favorite() async {
    try {} catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete all task
  static Future<void> deleteAllRemovedTask({List<Task>? taskList}) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(GetStorage().read('email'));
      for (var task in taskList!) {
        data.doc(task.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
