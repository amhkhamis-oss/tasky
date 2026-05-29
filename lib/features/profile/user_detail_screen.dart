import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/core/widget/custom_text_form_field.dart';

class UserDetailScreen extends StatefulWidget {
  UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationQuoteController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    setState(() {
      userNameController.text =
          PrefrenceManager().getString(StorageKey.username) ?? "";
      motivationQuoteController.text =
          PrefrenceManager().getString('motivation_quote') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                hintText: 'Usama Elgendy',
                text: 'User Name',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Your User Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: motivationQuoteController,
                hintText: 'One task at a time. One step closer.',
                text: 'Motivation Quote',
                maxlines: 5,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await PrefrenceManager().setString(
                        StorageKey.username,
                        userNameController.value.text,
                      );
                      await PrefrenceManager().setString(
                        'motivation_quote',
                        motivationQuoteController.value.text.trim(),
                      );
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text(
                    "Save Changes",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
