import 'package:get/get.dart';

import '../db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasklist = <Task>[].obs;

  Future<int> addtask({required Task task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTask() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();

    tasklist.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTask(int id) async {
    await DBHelper.delete(id);
    getTask();
  }

  void deleteAll() async {
    await DBHelper.deleteall();
    getTask();
  }

  void updateTask(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
