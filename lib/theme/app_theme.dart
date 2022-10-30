import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0D47A1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(backgroundColor: primary, elevation: 0),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      shape: const StadiumBorder(),
      elevation: 0,
    )),

    // ButtonThemeData
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        elevation: 10,
      ),
    ),
  );
}
