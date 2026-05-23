import 'package:flutter/material.dart';
import 'package:tasky3/models/task_model.dart';
import 'package:tasky3/core/components/custom_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyMessage;
  final Function(int? id) onDelete;
  final Function onEdit;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          )
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
            padding: EdgeInsets.only(bottom: 60),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return CustomItemWidget(
                model: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                },
                onDelete: (int? id) {
                  onDelete(id);
                },
                onEdit: () => onEdit(),
              );
            },
          );
  }
}
