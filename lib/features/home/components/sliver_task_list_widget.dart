import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/features/home/home_controller.dart';
import 'package:tasky3/core/components/custom_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
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
                : controller.task.isEmpty
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

                      itemCount: controller.task.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomItemWidget(
                          model: controller.task[index],
                          onChanged: (bool? value) {
                            controller.doneTask(value, index);
                            // onTap(value, index);
                          },
                          onDelete: (int? id) {
                            controller.deleteTask(id);
                            // onDelete(id);
                          },
                          onEdit: () => controller.loadTasks(),
                        );
                      },
                    ),
                  );
          },
    );
  }
}
