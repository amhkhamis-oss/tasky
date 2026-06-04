import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/features/add_task/add_task.dart';
import 'package:tasky3/features/home/home_controller.dart';
import 'package:tasky3/core/widget/custom_svg_picture.dart';
import 'package:tasky3/features/home/components/achieved_task_list_widget.dart';
import 'package:tasky3/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky3/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky3/features/tasks/tasks_controller.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 44,
          child: Builder(
            builder: (BuildContext builderContext) {
              return FloatingActionButton.extended(
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
                  if (result != null && result) {
                    builderContext.read<TasksController>().init();
                  }
                },
                icon: Icon(Icons.add),
                label: Text(
                  "Add New Task",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              );
            },
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
                          Selector<HomeController, String?>(
                            selector:
                                (
                                  BuildContext context,
                                  HomeController controller,
                                ) {
                                  return controller.userImage;
                                },
                            builder: (context, String? userImage, child) =>
                                CircleAvatar(
                                  backgroundImage: userImage == null
                                      ? AssetImage('assets/images/person.png')
                                      : FileImage(File(userImage)),
                                ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector:
                                    (
                                      BuildContext context,
                                      HomeController controller,
                                    ) {
                                      return controller.username;
                                    },
                                builder:
                                    (
                                      BuildContext context,
                                      String? username,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        "Good Evening ,$username",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      );
                                    },
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
                      AchievedTaskListWidget(),
                      SizedBox(height: 8),
                      HighPriorityTasksWidget(),
                      SizedBox(height: 24),
                      Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SliverTaskListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
