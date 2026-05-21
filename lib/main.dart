import 'package:flutter/material.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';
import 'package:tasky3/core/theme/dark_theme.dart';
import 'package:tasky3/core/theme/light_theme.dart';
import 'package:tasky3/core/theme/theme_controller.dart';
import 'package:tasky3/screens/main_screen.dart';
import 'package:tasky3/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrenceManager().init();
  ThemeController().init();

  String? userName = PrefrenceManager().getString('username');
  runApp(
    ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: value,
          darkTheme: darkTheme,
          home: (userName == null) ? WelcomeScreen() : MainScreen(),
        );
      },
    ),
  );
}
