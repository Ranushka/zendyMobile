import 'package:flutter/material.dart';

final _textColorPrimary = Colors.grey.shade200;
final _textColorSecondary = Colors.grey.shade400;
final _hintColor = Colors.orange.shade600;
final _hintColorLight = Colors.grey.shade400;
const _primaryColor = Colors.orange;
final _primaryColorLight = Colors.orange.shade50;
final _primaryColorDark = Color.fromARGB(255, 190, 142, 37);
const _primaryBg = Colors.black;
final _btnColor = Colors.orange.shade800;

var darkTheme = ThemeData(
  focusColor: _hintColor,
  highlightColor: _hintColor,
  splashColor: _hintColor,
  primaryColor: _primaryColor,
  primaryColorLight: _primaryColorLight,
  primaryColorDark: _primaryColorDark,
  hintColor: _hintColorLight,
  iconTheme: const IconThemeData(
    color: _primaryColor,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      color: _textColorPrimary,
      fontFamily: 'Lora',
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: _textColorPrimary,
      fontFamily: 'Lora',
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: _textColorPrimary,
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
      color: _textColorSecondary,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      color: _textColorSecondary,
    ),
    titleMedium: TextStyle(
      fontSize: 12,
      color: _textColorSecondary,
      fontFamily: 'SourceSansPro',
    ),
  ),
  fontFamily: 'SourceSansPro',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _btnColor,
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _btnColor,
      side: const BorderSide(
        color: _primaryColor,
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: _primaryColor,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _primaryBg,
    iconTheme: IconThemeData(
      color: Colors.blueGrey[800],
    ),
  ),
  colorScheme: const ColorScheme.dark(
    secondary: Colors.orange,
  ),
);
