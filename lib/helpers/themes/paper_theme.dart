import 'package:flutter/material.dart';

final paperTheme = ThemeData(
  // accentColor: Colors.orange[100],
  focusColor: Colors.orange[100],
  highlightColor: Colors.orange[100],
  splashColor: Colors.orange[100],
  primaryColor: Colors.orange,
  primaryColorLight: Colors.orange[50],
  hintColor: Colors.grey.shade400,
  iconTheme: const IconThemeData(color: Colors.orange),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      color: Colors.grey.shade900,
      fontFamily: 'Lora',
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade900,
      fontFamily: 'Lora',
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade900,
      fontFamily: 'Lora',
    ),
    headlineMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade600,
      fontFamily: 'Lora',
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: Colors.grey.shade800,
      fontFamily: 'SourceSansPro',
    ),
    titleMedium: TextStyle(
      fontSize: 12,
      color: Colors.grey.shade800,
      fontFamily: 'SourceSansPro',
    ),
  ),
  fontFamily: 'SourceSansPro',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.orange.shade800,
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.orange[800],
      side: const BorderSide(color: Colors.orange),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blueGrey[900]),
  ),
  colorScheme: const ColorScheme.light(primary: Color(0xff6200ee)),
);
