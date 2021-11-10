import 'package:flutter/material.dart';

final defaultTheme = ThemeData(
  accentColor: Colors.orange[100],
  focusColor: Colors.orange[100],
  highlightColor: Colors.orange[100],
  splashColor: Colors.orange[100],
  primaryColor: Colors.orange,
  primaryColorLight: Colors.orange[50],
  hintColor: Colors.grey.shade400,
  backgroundColor: Colors.white,
  iconTheme: new IconThemeData(color: Colors.orange),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 28,
      color: Colors.grey.shade900,
      fontFamily: 'Lora',
    ),
    headline2: TextStyle(
      fontSize: 20,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade900,
      fontFamily: 'Lora',
    ),
    headline3: TextStyle(
      fontSize: 16,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade900,
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
      color: Colors.grey.shade800,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
      color: Colors.grey.shade800,
    ),
    subtitle1: TextStyle(
      fontSize: 12,
      color: Colors.grey.shade800,
      fontFamily: 'SourceSansPro',
    ),
  ),
  fontFamily: 'SourceSansPro',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(primary: Colors.orange),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(fontWeight: FontWeight.w500),
      primary: Colors.orange.shade800,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: Colors.orange[800],
      side: BorderSide(color: Colors.orange),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blueGrey[900]),
  ),
);
