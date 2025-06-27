import 'package:flutter/material.dart';

ThemeData customTheme = ThemeData(
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color(0xff1679ab),
        ),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    scaffoldBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Color(0xff5dedb7),
    ),
    colorSchemeSeed: Color(0xff1679ab));
