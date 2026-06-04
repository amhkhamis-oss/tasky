import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/features/tasks/tasks_controller.dart';

class AchievedTaskListWidget extends StatelessWidget {
  const AchievedTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, TasksController controller, child) => Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Achieved Tasks",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${controller.totalDoneTasks} Out of ${controller.totalTask} Done",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Center(
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: CircularProgressIndicator(
                        value: controller.percentage,
                        backgroundColor: Color(0xFF6D6D6D),
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF15B86C)),
                      ),
                    ),
                  ),
                  Text(
                    "${(controller.percentage * 100).toInt()}%",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
