import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? userImage;
  List<TaskModel> task = [];
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percentage = 0;

  void init() {
    loadTasks();
    loadUserData();
  }

  Future<void> doneTask(bool? value, int? index) async {
    task[index!].isCheck = value ?? false;

    final updatedTask = task.map((e) => e.toMap()).toList();
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    caluclateOperating();
  }

  void loadTasks() async {
    isLoading = true;
    final finalTask = PrefrenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      task = tasksDecode.map((e) {
        return TaskModel.fromJson(e);
      }).toList();
      caluclateOperating();
    }
    isLoading = false;
    notifyListeners();
  }

  void caluclateOperating() {
    totalTask = task.length;
    totalDoneTasks = task.where((e) => e.isCheck).length;
    percentage = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
    notifyListeners();
  }

  void loadUserData() async {
    username = PrefrenceManager().getString(StorageKey.username);
    userImage = PrefrenceManager().getString(StorageKey.userImage);

    notifyListeners();
  }

  void deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    final tasksList = PrefrenceManager().getString(StorageKey.tasks);
    if (tasksList != null) {
      final tasksDecode = jsonDecode(tasksList) as List<dynamic>;
      tasks = tasksDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
    }
    task.removeWhere((element) => element.id == id);

    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((task) => task.toMap()).toList()),
    );
    notifyListeners();
  }
}
