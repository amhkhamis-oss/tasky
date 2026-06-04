import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/core/components/custom_item_widget.dart';
import 'package:tasky3/features/tasks/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ThemeController().isDark()
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                : controller.tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No Data",
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

                      itemCount: controller.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomItemWidget(
                          model: controller.tasks[index],
                          onChanged: (bool? value) {
                            controller.doneTask(value, index);
                            // onTap(value, index);
                          },
                          onDelete: (int? id) {
                            controller.deleteTask(id);
                            // onDelete(id);
                          },
                          onEdit: () => controller.init(),
                        );
                      },
                    ),
                  );
          },
    );
  }
}
