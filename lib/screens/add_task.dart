import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/screens/models/task_model.dart';
import 'package:tasky3/widget/custom_text_form_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey();

  TextEditingController taskNameController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("New Task")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SafeArea(
            child: Form(
              key: _key,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High Priority",
                        style: Theme.of(context).textTheme.titleMedium,
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
                  Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        final taskJson = PrefrenceManager().getString('tasks');
                        List listTasks = [];
                        if (taskJson != null) {
                          listTasks = jsonDecode(taskJson);
                        }
                        TaskModel model = TaskModel(
                          id: listTasks.length + 1,
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                        );
                        listTasks.add(model.toMap());
                        final tasksEncode = jsonEncode(listTasks);
                        await PrefrenceManager().setString(
                          'tasks',
                          tasksEncode,
                        );
                        Navigator.of(context).pop(true);
                      }
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
      ),
    );
  }
}
