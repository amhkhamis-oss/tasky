import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/features/tasks/tasks_controller.dart';
import 'package:tasky3/core/components/task_list_widget.dart';

// ignore: must_be_immutable
class HighPriorityScreen extends StatelessWidget {
  HighPriorityScreen({super.key});

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
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
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF15B86C)))
          : Consumer<TasksController>(
              builder: (BuildContext context, value, Widget? child) {
                return TaskListWidget(
                  tasks: value.highPriority,
                  onTap: (bool? value, int? index) async {
                    controller.doneHighPrirityTasks(value, index);
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
    );
  }
}
