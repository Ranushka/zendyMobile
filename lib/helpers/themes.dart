import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/helpers/themes/dark_theme.dart';
import 'package:zendy/helpers/themes/default_theme.dart';
import 'package:zendy/helpers/themes/paper_theme.dart';

final customTheme = {
  "DEFAULT": defaultTheme,
  "PAPER": paperTheme,
  "DARK": darkTheme,
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
  final logoPath =
      isDark ? 'assets/images/logo_light.png' : 'assets/images/logo_dark.png';

  return InkWell(
    onTap: () => Get.toNamed(Goto.home),
    child: Image(
      width: width.toDouble(),
      image: AssetImage(logoPath),
    ),
  );
}
