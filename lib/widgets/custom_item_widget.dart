import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/enums/task_item_actions_enum.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/screens/models/task_model.dart';
import 'package:tasky3/widget/custom_check_box.dart';
import 'package:tasky3/widget/custom_text_form_field.dart';

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: ThemeController().isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CustomCheckBox(
            value: model.isCheck,
            onChanged: (bool? value) {
              onChanged(value);
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.taskName,
                  style: model.isCheck
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController().isDark()
                  ? model.isCheck
                        ? Color(0xFFA0A0A0)
                        : Color(0xFFC6C6C6)
                  : model.isCheck
                  ? Color(0xFF3A4640)
                  : Color(0xFF6A6A6A),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isCheck);
                case TaskItemActionsEnum.edit:
                  final result = await _showButtomSheet(context, model);

                  if (result == true) {
                    onEdit();
                  }

                case TaskItemActionsEnum.delete:
                  _showAlertDialog(context);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are You Sure You Want Delete This Task ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                onDelete(model.id);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtomSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> key = GlobalKey();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder:
                (
                  BuildContext context,
                  void Function(void Function()) setState,
                ) {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ).copyWith(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),

                      child: SafeArea(
                        child: Form(
                          key: key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              CustomTextFormField(
                                controller: taskNameController,
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
                                controller: taskDescriptionController,
                                hintText:
                                    'Finish onboarding UI and hand off to devs by Thursday.',
                                text: 'Task Description',
                                maxlines: 5,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "High Priority",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Switch(
                                    value: isHighPriority,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isHighPriority = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width,
                                    40,
                                  ),
                                ),
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  if (key.currentState!.validate()) {
                                    final taskJson = PrefrenceManager()
                                        .getString('tasks');
                                    List listTasks = [];
                                    if (taskJson != null) {
                                      listTasks = jsonDecode(taskJson);
                                    }
                                    TaskModel newModel = TaskModel(
                                      id: model.id,
                                      taskName: taskNameController.text,
                                      taskDescription:
                                          taskDescriptionController.text,
                                      isHighPriority: isHighPriority,
                                      isCheck: model.isCheck,
                                    );

                                    final int index = listTasks.indexWhere(
                                      (e) => e['id'] == model.id,
                                    );
                                    // listTasks.add(model.toMap());

                                    listTasks[index] = newModel.toMap();

                                    await PrefrenceManager().setString(
                                      'tasks',
                                      jsonEncode(listTasks),
                                    );
                                    Navigator.of(context).pop(true);
                                  }
                                },
                                label: Text(
                                  "Edit Task",
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
      },
    );
  }
}
