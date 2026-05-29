import 'package:flutter/material.dart';
import 'package:tasky3/core/constants/storage_key.dart';
import 'package:tasky3/core/services/prefrence-manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  init() {
    bool result = PrefrenceManager().getBool(StorageKey.theme) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefrenceManager().setbool(StorageKey.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefrenceManager().setbool(StorageKey.theme, true);
    }
  }

  bool isDark() => themeNotifier.value == ThemeMode.dark;
}
