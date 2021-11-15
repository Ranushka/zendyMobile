import 'package:flutter/material.dart';

final _textColorPrimary = Colors.grey.shade200;
final _textColorSecondary = Colors.grey.shade400;
final _hintColor = Colors.orange.shade600;
final _hintColorLight = Colors.grey.shade400;
final _primaryColor = Colors.orange;
final _primaryColorLight = Colors.orange.shade50;
final _primaryBg = Colors.black;
final _btnColor = Colors.orange.shade800;

var darkTheme = ThemeData(
  accentColor: _hintColor,
  focusColor: _hintColor,
  highlightColor: _hintColor,
  splashColor: _hintColor,
  primaryColor: _primaryColor,
  primaryColorLight: _primaryColorLight,
  hintColor: _hintColorLight,
  backgroundColor: _primaryBg,
  iconTheme: new IconThemeData(
    color: _primaryColor,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 28,
      color: _textColorPrimary,
      fontFamily: 'Lora',
    ),
    headline2: TextStyle(
      fontSize: 20,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: _textColorPrimary,
      fontFamily: 'Lora',
    ),
    headline3: TextStyle(
      fontSize: 16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: _textColorPrimary,
      fontFamily: 'Lora',
    ),
    headline4: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.grey.shade600,
      fontFamily: 'Lora',
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      color: _textColorSecondary,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
      color: _textColorSecondary,
    ),
    subtitle1: TextStyle(
      fontSize: 12,
      color: _textColorSecondary,
      fontFamily: 'SourceSansPro',
    ),
  ),
  fontFamily: 'SourceSansPro',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: _primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(fontWeight: FontWeight.w500),
      primary: _btnColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: _btnColor,
      side: BorderSide(
        color: _primaryColor,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
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
);
