import 'package:flutter/material.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  init() {
    bool result = PrefrenceManager().getBool("theme") ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefrenceManager().setbool('theme', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefrenceManager().setbool('theme', true);
    }
  }

  bool isDark() => themeNotifier.value == ThemeMode.dark;
}
