import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/models/task_model.dart';
import 'package:tasky3/core/components/task_list_widget.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  List<TaskModel> completedTasks = [];
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
    final finalTask = PrefrenceManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        completedTasks = tasksDecode
            .map((e) {
              return TaskModel.fromJson(e);
            })
            .where((e) => e.isCheck)
            .toList();
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
      completedTasks.removeWhere((element) => element.id == id);
    }

    setState(() {
      tasks.removeWhere((element) => element.id == id);
    });
    await PrefrenceManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((task) => task.toMap()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Completed Tasks",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: 28),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TaskListWidget(
                      tasks: completedTasks,
                      onTap: (bool? value, int? index) async {
                        setState(() {
                          completedTasks[index!].isCheck = value ?? false;
                        });

                        final allData = PrefrenceManager().getString(
                          StorageKey.tasks,
                        );
                        if (allData != null) {
                          List<TaskModel> allTasks =
                              (jsonDecode(allData) as List<dynamic>).map((e) {
                                return TaskModel.fromJson(e);
                              }).toList();
                          int newIndex = allTasks.indexWhere(
                            (e) => e.id == completedTasks[index!].id,
                          );
                          allTasks[newIndex] = completedTasks[index!];
                          PrefrenceManager().setString(
                            StorageKey.tasks,
                            jsonEncode(allTasks.map((e) => e.toMap()).toList()),
                          );
                          loadTasks();
                        }
                      },
                      emptyMessage: 'No Completed Tasks',
                      onDelete: (id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        loadTasks();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
