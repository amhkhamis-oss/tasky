import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/screens/user_detail_screen.dart';
import 'package:tasky3/screens/welcome_screen.dart';
import 'package:tasky3/widget/custom_svg_picture.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userName;
  String? motivationQoute;
  bool isDarkMode = true;
  String? userImage;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    setState(() {
      userName = PrefrenceManager().getString('username');
      motivationQoute = PrefrenceManager().getString('motivation_quote') ?? "";
      userImage = PrefrenceManager().getString('user_image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Profile", style: Theme.of(context).textTheme.labelSmall),
            SizedBox(height: 18),
            Center(
              child: Column(
                children: [
                  //Stack
                  Stack(
                    alignment: AlignmentGeometry.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundImage: userImage == null
                            ? AssetImage('assets/images/person.png')
                            : FileImage(File(userImage!)),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            _showImageSourceDialog(context, (XFile file) {
                              _saveImage(file);
                              setState(() {
                                userImage = file.path;
                              });
                            });
                          },
                          child: Icon(Icons.camera_alt, size: 26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    userName ?? "",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    motivationQoute!.isNotEmpty
                        ? motivationQoute!
                        : "One task at a time. One step closer.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text("Profile Info", style: Theme.of(context).textTheme.labelSmall),
            SizedBox(height: 20),
            //List TIle
            ListTile(
              onTap: () async {
                final bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UserDetailScreen();
                    },
                  ),
                );
                if (result != null || result == true) {
                  loadUserData();
                }
              },
              contentPadding: EdgeInsets.zero,
              title: Text("User Details"),
              leading: CustomSvgPicture(path: 'assets/images/profile.svg'),
              trailing: CustomSvgPicture(path: 'assets/images/arrow.svg'),
            ),
            Divider(thickness: 2),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Dark Mode"),
              leading: CustomSvgPicture(path: 'assets/images/moon.svg'),
              trailing: ValueListenableBuilder(
                valueListenable: ThemeController.themeNotifier,
                builder: (context, value, child) {
                  return Switch(
                    value:
                        ThemeController.themeNotifier.value == ThemeMode.dark,
                    onChanged: (bool value) async {
                      ThemeController.toggleTheme();
                    },
                  );
                },
              ),
            ),
            Divider(thickness: 2),
            ListTile(
              onTap: () async {
                PrefrenceManager().remove("tasks");
                PrefrenceManager().remove("username");
                PrefrenceManager().remove("motivation_quote");

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ),
                  (route) => false,
                );
              },
              contentPadding: EdgeInsets.zero,
              title: Text("Log Out"),
              leading: CustomSvgPicture(path: 'assets/images/log-out.svg'),
              trailing: CustomSvgPicture(path: 'assets/images/arrow.svg'),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context, Function(XFile) selected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Choose Your Option",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selected(image);
                }
              },

              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selected(image);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text("Gallery"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //mmmmm

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    await PrefrenceManager().setString('user_image', newFile.path);
  }
}
