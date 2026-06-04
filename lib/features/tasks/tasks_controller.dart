import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percentage = 0;

  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriority = [];

  void init() {
    _loadTasks();
  }

  void _loadData() {
    todoTasks = tasks.where((e) => !e.isCheck).toList();
    completedTasks = tasks.where((e) => e.isCheck).toList();
    highPriority = tasks.where((e) => e.isHighPriority).toList();
    highPriority = highPriority.reversed.toList();
  }

  void _loadTasks() {
    isLoading = true;
    final finalTask = PrefrenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = tasksDecode.map((e) {
        return TaskModel.fromJson(e);
      }).toList();
    }
    isLoading = false;
    _loadData();
    caluclateOperating();

    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((element) => element.id == id);

    _loadData();
    final updatedTask = tasks.map((e) => e.toMap()).toList();
    PrefrenceManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    caluclateOperating();

    notifyListeners();
  }

  void caluclateOperating() {
    totalTask = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isCheck).length;
    percentage = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
    notifyListeners();
  }

  void doneTask(bool? value, int id) async {
    final index = tasks.indexWhere((e) => e.id == id);
    tasks[index].isCheck = value ?? false;

    _loadData();
    caluclateOperating();

    final updatedTask = tasks.map((e) => e.toMap()).toList();
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }
}
