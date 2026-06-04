import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/features/tasks/tasks_controller.dart';
import 'package:tasky3/core/components/task_list_widget.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
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
              child: controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<TasksController>(
                      builder:
                          (
                            BuildContext context,
                            valueController,
                            Widget? child,
                          ) {
                            return TaskListWidget(
                              tasks: valueController.completedTasks,
                              onTap: (bool? value, int? index) async {
                                controller.doneTask(
                                  value,
                                  valueController.completedTasks[index!].id,
                                );
                              },
                              emptyMessage: 'No Completed Tasks',
                              onDelete: (id) {
                                controller.deleteTask(id);
                              },
                              onEdit: () {
                                controller.init();
                              },
                            );
                          },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
