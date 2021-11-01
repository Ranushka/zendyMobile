import 'package:flutter/material.dart';

final customTheme = {
  "BASE": ThemeData(
    accentColor: Colors.orange[100],
    focusColor: Colors.orange[100],
    highlightColor: Colors.orange[100],
    splashColor: Colors.orange[100],
    primaryColor: Colors.orange,
    primaryColorLight: Colors.orange[50],
    hintColor: Colors.grey.shade400,
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFamily: 'PlayfairDisplay',
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
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blueGrey[900]),
    ),
  ),
  "LIGHT": ThemeData.light(),
  "BLACK": ThemeData(
    scaffoldBackgroundColor: Colors.grey[50],
    primaryColor: Colors.black,
    primaryColorLight: Colors.black54,
    primaryColorDark: Colors.black54,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
};

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}
