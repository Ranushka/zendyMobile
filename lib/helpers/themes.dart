import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/helpers/helpers.dart';

final customTheme = {
  "DEFAULT": ThemeData(
    accentColor: Colors.orange[100],
    focusColor: Colors.orange[100],
    highlightColor: Colors.orange[100],
    splashColor: Colors.orange[100],
    primaryColor: Colors.orange,
    primaryColorLight: Colors.orange[50],
    hintColor: Colors.grey.shade400,
    backgroundColor: Colors.white,
    // inputDecorationTheme: InputDecorationTheme()
    iconTheme: new IconThemeData(color: Colors.orange),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        // fontWeight: FontWeight.bold,
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
  ),
  "PAPER": ThemeData(
    accentColor: Colors.orange[100],
    focusColor: Colors.orange[100],
    highlightColor: Colors.orange[100],
    splashColor: Colors.orange[100],
    primaryColor: Colors.orange,
    primaryColorLight: Colors.orange[50],
    hintColor: Colors.grey.shade400,
    backgroundColor: Colors.amber[50],
    iconTheme: new IconThemeData(color: Colors.orange),
    textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 28,
          // fontWeight: FontWeight.bold,
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
          fontFamily: 'SourceSansPro',
        ),
        subtitle1: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade800,
          fontFamily: 'SourceSansPro',
        )),
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
  ),
  "DARK": ThemeData(
    accentColor: Colors.orange[100],
    focusColor: Colors.orange[100],
    highlightColor: Colors.orange[100],
    splashColor: Colors.orange[100],
    primaryColor: Colors.orange,
    primaryColorLight: Colors.grey[900],
    hintColor: Colors.grey.shade400,
    backgroundColor: Colors.black87,
    iconTheme: new IconThemeData(color: Colors.orange[400]),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade100,
        fontFamily: 'Lora',
      ),
      headline2: TextStyle(
        fontSize: 20,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade100,
        fontFamily: 'Lora',
      ),
      headline3: TextStyle(
        fontSize: 16,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade100,
        fontFamily: 'Lora',
      ),
      headline4: TextStyle(
        fontSize: 14,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade200,
        fontFamily: 'Lora',
      ),
      bodyText1: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade500,
        fontFamily: 'SourceSansPro',
      ),
      subtitle1: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade100,
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
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.blueGrey[900]),
    ),
  ),
};

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Widget getLogoImg(width) {
  width ??= 80;
  final AuthController authController = Get.find();

  final isDark = authController.currentUser.value.theme == 'DARK';
  final logoPath = isDark
      ? 'assets/images/zendy_logo_dark.png'
      : 'assets/images/zendy_logo.png';

  return InkWell(
    onTap: () => Get.toNamed(Goto.home),
    child: Image(
      width: width.toDouble(),
      image: AssetImage(logoPath),
    ),
  );
}
