import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(
      color: Colors.white
    )
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 16.0, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 16.0, color: Colors.white),

    displayLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    displayMedium: TextStyle(fontSize: 16.0, color: Colors.white),
    displaySmall: TextStyle(fontSize: 16.0, color: Colors.white),

    titleLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    titleMedium: TextStyle(fontSize: 16.0, color: Colors.white),
    titleSmall: TextStyle(fontSize: 16.0, color: Colors.white),

    labelLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    labelMedium: TextStyle(fontSize: 16.0, color: Colors.white),
    labelSmall: TextStyle(fontSize: 16.0, color: Colors.white),

    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
    bodySmall: TextStyle(fontSize: 14.0, color: Colors.white),
  ),
);
