import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky3/features/add_task/add_task_controller.dart';
import 'package:tasky3/core/widget/custom_text_form_field.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => AddTaskController(),
        builder: (context, child) {
          final controller = context.read<AddTaskController>();
          return Scaffold(
            appBar: AppBar(title: Text("New Task")),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                child: Form(
                  key: controller.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      CustomTextFormField(
                        controller: controller.taskNameController,
                        hintText: 'Finish UI design for login screen',
                        text: "Task Name",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Task Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 28),
                      CustomTextFormField(
                        controller: controller.taskDescriptionController,
                        hintText:
                            'Finish onboarding UI and hand off to devs by Thursday.',
                        text: 'Task Description',
                        maxlines: 5,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "High Priority",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Consumer<AddTaskController>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                                  return Switch(
                                    value: value.isHighPriority,
                                    onChanged: (bool value) {
                                      controller.toggle(value);
                                    },
                                  );
                                },
                          ),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        icon: Icon(Icons.add),
                        onPressed: () {
                          controller.addTask(context);
                        },
                        label: Text(
                          "Add Task",
                          style: TextStyle(
                            color: Color(0xFFFFFCFC),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
