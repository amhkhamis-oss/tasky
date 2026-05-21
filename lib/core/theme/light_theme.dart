import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF161F1B),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    backgroundColor: Color(0xFFF6F7F9),
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return null;
      }
      return Color(0xFF9E9E9E);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Color(0xFFFFFCFC),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 20),
    labelLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    fillColor: Color(0xFFFFFFFF),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 1, color: Color(0xFFD1DAD6)),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  splashFactory: NoSplash.splashFactory,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFF15B86C),
    unselectedItemColor: Color(0xFF3A4640),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shadowColor: Color(0xFF15B86C),
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1),
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
    elevation: 2,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20, color: Colors.black),
    ),
  ),
);
