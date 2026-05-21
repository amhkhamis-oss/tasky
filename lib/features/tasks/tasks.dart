import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/screens/models/task_model.dart';
import 'package:tasky3/widgets/task_list_widget.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<TaskModel> todoTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    loadTasks();
    super.initState();
  }

  void loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PrefrenceManager().getString('tasks');
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        todoTasks = tasksDecode
            .map((e) {
              return TaskModel.fromJson(e);
            })
            .where((e) => !e.isCheck)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];

    final tasksList = PrefrenceManager().getString('tasks');
    if (tasksList != null) {
      final tasksDecode = jsonDecode(tasksList) as List<dynamic>;
      tasks = tasksDecode.map((e) => TaskModel.fromJson(e)).toList();
      todoTasks.removeWhere((element) => element.id == id);
    }

    setState(() {
      tasks.removeWhere((element) => element.id == id);
    });
    await PrefrenceManager().setString(
      'tasks',
      jsonEncode(tasks.map((task) => task.toMap()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Scaffold(
        appBar: AppBar(title: Text("To Do Tasks")),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TaskListWidget(
                tasks: todoTasks,
                onTap: (bool? value, int? index) async {
                  setState(() {
                    todoTasks[index!].isCheck = value ?? false;
                  });

                  final allData = PrefrenceManager().getString('tasks');
                  if (allData != null) {
                    List<TaskModel> allTasks =
                        (jsonDecode(allData) as List<dynamic>).map((e) {
                          return TaskModel.fromJson(e);
                        }).toList();
                    int newIndex = allTasks.indexWhere(
                      (e) => e.id == todoTasks[index!].id,
                    );
                    allTasks[newIndex] = todoTasks[index!];
                    PrefrenceManager().setString(
                      'tasks',
                      jsonEncode(allTasks.map((e) => e.toMap()).toList()),
                    );
                    loadTasks();
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
      ),
    );
  }
}
