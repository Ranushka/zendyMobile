import 'package:flutter/material.dart';

// final c = {
//   'transparent': Colors.transparent,
//   'primary': Colors.orange,
// };

class CusColors {
  final transparent = Colors.transparent;
  final primary = Colors.orange;
  final primaryLight = Colors.orange[100];
  final acc1 = Colors.black87;
  final acc2 = Colors.black54;
}

final c = CusColors();

final customTheme = {
  "BASE": ThemeData(
    focusColor: c.primaryLight,
    highlightColor: c.primaryLight,
    splashColor: c.primaryLight,
    primaryColor: Colors.orange,
    primaryColorLight: Colors.orange[50],
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
      style: OutlinedButton.styleFrom(primary: Colors.blueGrey[900]),
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
