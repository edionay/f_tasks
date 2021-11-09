import 'package:f_tasks/models/task.dart';
import 'package:f_tasks/services/database_helper.dart';
import 'package:flutter/cupertino.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  initialize() async {
    _tasks = await DatabaseHelper.instance.readAllTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await DatabaseHelper.instance.create(task);
    updateTasks();
  }

  void updateTasks() async {
    _tasks = await DatabaseHelper.instance.readAllTasks();
    notifyListeners();
  }
}
