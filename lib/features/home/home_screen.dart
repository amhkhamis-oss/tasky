import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/features/add_task/add_task.dart';
import 'package:tasky3/models/task_model.dart';
import 'package:tasky3/core/widget/custom_svg_picture.dart';
import 'package:tasky3/features/home/components/achieved_task_list_widget.dart';
import 'package:tasky3/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky3/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? userImage;
  List<TaskModel> task = [];
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percentage = 0;

  @override
  void initState() {
    super.initState();
    loadTasks();
    _loadUserName();
  }

  void loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTask = PrefrenceManager().getString('tasks');
    if (finalTask != null) {
      final tasksDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        task = tasksDecode.map((e) {
          return TaskModel.fromJson(e);
        }).toList();
        _caluclateOperating();
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
      tasks.removeWhere((element) => element.id == id);
    }
    setState(() {
      task.removeWhere((element) => element.id == id);
    });
    await PrefrenceManager().setString(
      'tasks',
      jsonEncode(tasks.map((task) => task.toMap()).toList()),
    );
  }

  void _caluclateOperating() {
    totalTask = task.length;
    totalDoneTasks = task.where((e) => e.isCheck).length;
    percentage = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  void _loadUserName() async {
    setState(() {
      username = PrefrenceManager().getString('username');
      userImage = PrefrenceManager().getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTask();
                },
              ),
            );
            if (result != null && result) loadTasks();
          },
          icon: Icon(Icons.add),
          label: Text(
            "Add New Task",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: userImage == null
                              ? AssetImage('assets/images/person.png')
                              : FileImage(File(userImage!)),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening ,$username ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "One task at a time.One step\n closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Yuhuu ,Your work Is ",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          "almost done ! ",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutColor(
                          path: 'assets/images/hand.svg',
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    //Achieved Tasks
                    AchievedTaskListWidget(
                      totalTasks: totalTask,
                      totalDoneTasks: totalDoneTasks,
                      percentage: percentage,
                    ),
                    SizedBox(height: 8),

                    HighPriorityTasksWidget(
                      tasks: task,
                      onTap: (value, index) async {
                        setState(() {
                          task[index!].isCheck = value ?? false;
                        });

                        final updatedTask = task.map((e) => e.toMap()).toList();
                        PrefrenceManager().setString(
                          'tasks',
                          jsonEncode(updatedTask),
                        );
                        _caluclateOperating();
                      },
                      refresh: () {
                        loadTasks();
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                      "My Tasks",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ThemeController().isDark()
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                  : SliverTaskListWidget(
                      tasks: task,
                      onTap: (value, index) async {
                        setState(() {
                          task[index!].isCheck = value ?? false;
                        });
                        final updatedTask = task.map((e) => e.toMap()).toList();
                        PrefrenceManager().setString(
                          'tasks',
                          jsonEncode(updatedTask),
                        );
                        _caluclateOperating();
                      },
                      emptyMessage: 'No Data',
                      onDelete: (id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        loadTasks();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
