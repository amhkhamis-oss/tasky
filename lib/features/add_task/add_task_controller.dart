import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();

  TextEditingController taskNameController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();

  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (key.currentState!.validate()) {
      final taskJson = PrefrenceManager().getString(StorageKey.tasks);
      List listTasks = [];
      if (taskJson != null) {
        listTasks = jsonDecode(taskJson);
      }
      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );
      listTasks.add(model.toMap());
      await PrefrenceManager().setString(
        StorageKey.tasks,
        jsonEncode(listTasks),
      );
    }
    Navigator.of(context).pop(true);
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
