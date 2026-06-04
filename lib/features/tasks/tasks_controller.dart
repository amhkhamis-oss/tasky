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

  void _loadTasks() {
    isLoading = true;
    final finalTask = PrefrenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = tasksDecode.map((e) {
        return TaskModel.fromJson(e);
      }).toList();
      todoTasks = tasks.where((e) => !e.isCheck).toList();
      completedTasks = tasks.where((e) => e.isCheck).toList();
      highPriority = tasks.where((e) => e.isHighPriority).toList();
    }
    isLoading = false;
    caluclateOperating();

    notifyListeners();
  }

  void doneToDoTasks(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isCheck = value ?? false;

    int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    _loadTasks();
    caluclateOperating();

    notifyListeners();
  }

  void doneCompletedTasks(bool? value, int? index) async {
    if (index == null) return;
    completedTasks[index].isCheck = value ?? false;

    int newIndex = tasks.indexWhere((e) => e.id == completedTasks[index].id);
    tasks[newIndex] = completedTasks[index];
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    _loadTasks();
    caluclateOperating();
    notifyListeners();
  }

  void doneHighPrirityTasks(bool? value, int? index) async {
    if (index == null) return;
    highPriority[index].isCheck = value ?? false;

    int newIndex = tasks.indexWhere((e) => e.id == highPriority[index].id);
    tasks[newIndex] = highPriority[index];
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toMap()).toList()),
    );
    _loadTasks();
    caluclateOperating();

    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((element) => element.id == id);
    todoTasks.removeWhere((e) => e.id == id);
    completedTasks.removeWhere((e) => e.id == id);
    highPriority.removeWhere((e) => e.id == id);

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

  void doneTask(bool? value, int? index) async {
    tasks[index!].isCheck = value ?? false;

    final updatedTask = tasks.map((e) => e.toMap()).toList();
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    caluclateOperating();
  }
}
