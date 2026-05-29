import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];

  init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;
    final finalTask = PrefrenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = tasksDecode.map((e) {
        return TaskModel.fromJson(e);
      }).toList();
      todoTasks = tasks.where((e) => !e.isCheck).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isCheck = value ?? false;

    int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    _loadTasks();
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((element) => element.id == id);
    todoTasks.removeWhere((e) => e.id == id);

    final updatedTask = tasks.map((e) => e.toMap()).toList();
    PrefrenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }
}
