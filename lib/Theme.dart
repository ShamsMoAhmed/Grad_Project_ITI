import 'package:flutter/material.dart';

final Color beige = Color(0xFFF5F5DC);
final Color brown = Color(0xFF8B4513);

final ThemeData theme = ThemeData(
  primarySwatch: Colors.brown,
  hintColor: beige,
  scaffoldBackgroundColor: beige,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: brown), // Replaces bodyText1
    bodyMedium: TextStyle(color: brown), // Replaces bodyText2
  ),
  appBarTheme: AppBarTheme(
    color: beige,
    iconTheme: IconThemeData(color: brown),
    titleTextStyle: TextStyle(
      color: brown, 
      fontSize: 20, 
      fontWeight: FontWeight.bold,
    ), // Replaces headline6 with titleTextStyle
  ),
);
