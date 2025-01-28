import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.lightBlueAccent, 
    selectionHandleColor: Colors.lightBlueAccent, 
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.lightBlueAccent,
    surface: Colors.white70,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.lightBlueAccent,
    foregroundColor: Colors.white,
  ),
);


ThemeData nightMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey.shade900,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white, 
    selectionColor: Colors.deepPurpleAccent.withOpacity(0.5), 
    selectionHandleColor: Colors.deepPurpleAccent, 
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Colors.deepPurpleAccent,
    surface: Colors.grey.shade700,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white70,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 71, 30, 184),
    foregroundColor: Colors.white,
  ),
);

