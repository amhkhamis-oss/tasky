import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/features/tasks/tasks_controller.dart';
import 'package:tasky3/core/components/task_list_widget.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Scaffold(
            appBar: AppBar(title: Text("To Do Tasks")),
            body: controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<TasksController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return TaskListWidget(
                        tasks: value.todoTasks,
                        onTap: (bool? value, int? index) async {
                          controller.doneTask(value, index);
                        },
                        emptyMessage: 'No Tasks Found',
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
        );
      },
    );
  }
}
