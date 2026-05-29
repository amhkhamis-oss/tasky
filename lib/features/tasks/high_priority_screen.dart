import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';
import 'package:tasky3/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  bool isCheck = false;
  List<TaskModel> listTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final tasks = PrefrenceManager().getString(StorageKey.tasks);
    if (tasks != null) {
      final tasksDecode = jsonDecode(tasks) as List<dynamic>;
      setState(() {
        listTasks = tasksDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isHighPriority)
            .toList();
        listTasks = listTasks.reversed.toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];

    final tasksList = PrefrenceManager().getString(StorageKey.tasks);
    if (tasksList != null) {
      final tasksDecode = jsonDecode(tasksList) as List<dynamic>;
      tasks = tasksDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
    }

    setState(() {
      listTasks.removeWhere((element) => element.id == id);
    });
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((task) => task.toMap()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "High Priority Tasks",
          style: TextStyle(
            color: Color(0xFFFFFCFC),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF15B86C)))
          : TaskListWidget(
              tasks: listTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  listTasks[index!].isCheck = value ?? false;
                });
                final allData = PrefrenceManager().getString(StorageKey.tasks);
                if (allData != null) {
                  List<TaskModel> allTasks =
                      (jsonDecode(allData) as List<dynamic>).map((e) {
                        return TaskModel.fromJson(e);
                      }).toList();
                  int newIndex = allTasks.indexWhere(
                    (e) => e.id == listTasks[index!].id,
                  );
                  allTasks[newIndex] = listTasks[index!];
                  await PrefrenceManager().setString(
                    StorageKey.tasks,
                    jsonEncode(allTasks.map((task) => task.toMap()).toList()),
                  );
                }
              },
              emptyMessage: 'No Tasks Found',
              onDelete: (id) {
                _deleteTask(id);
              },
              onEdit: () {
                loadTasks();
              },
            ),
    );
  }
}
