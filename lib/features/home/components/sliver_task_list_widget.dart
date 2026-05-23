import 'package:flutter/material.dart';
import 'package:tasky3/models/task_model.dart';
import 'package:tasky3/core/components/custom_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
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
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 53),
            sliver: SliverList.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },

              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
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
            ),
          );
  }
}
