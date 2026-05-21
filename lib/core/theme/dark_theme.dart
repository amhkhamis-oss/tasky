import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF181818),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFFFFCFC),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    backgroundColor: Color(0xFF181818),
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Color(0xFF6E6E6E);
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
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 20),
    labelLarge: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E)),
  inputDecorationTheme: InputDecorationThemeData(
    hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
    fillColor: Color(0xFF282828),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),
  splashFactory: NoSplash.splashFactory,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFF15B86C),
    unselectedItemColor: Color(0xFFC6C6C6),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shadowColor: Color(0xFF15B86C),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xFF15B86C), width: 1),
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
    elevation: 2,
    labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 20)),
  ),
);
