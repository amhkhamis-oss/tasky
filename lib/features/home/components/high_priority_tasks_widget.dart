import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/screens/high_priority_screen.dart';
import 'package:tasky3/screens/models/task_model.dart';
import 'package:tasky3/widget/custom_check_box.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(
                      color: Color(0xFF15B86C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      tasks.reversed.where((e) => e.isHighPriority).length > 4
                      ? 4
                      : tasks.reversed.where((e) => e.isHighPriority).length,

                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks.reversed
                        .where((e) => e.isHighPriority)
                        .toList()[index];
                    return Row(
                      children: [
                        CustomCheckBox(
                          value: task.isCheck,
                          onChanged: (bool? value) {
                            final index = tasks.indexWhere(
                              (e) => e.id == task.id,
                            );
                            onTap(value, index);
                          },
                        ),
                        Flexible(
                          child: Text(
                            task.taskName,
                            style: task.isCheck
                                ? Theme.of(context).textTheme.titleLarge!
                                      .copyWith(color: Color(0xFFA0A0A0))
                                : Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) {
                      return HighPriorityScreen();
                    },
                  ),
                );
                refresh();
              },
              child: Container(
                height: 50,
                width: 48,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: ThemeController().isDark()
                      ? Color(0xFF282828)
                      : Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF6E6E6E)),
                ),
                child: SvgPicture.asset(
                  'assets/images/arrow_right.svg',
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
