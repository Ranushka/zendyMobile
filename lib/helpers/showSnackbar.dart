import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar({
  String title = '',
  String message = '',
  Color colorText = Colors.white,
  Color backgroundColor = Colors.black54,
}) {
  Get.snackbar(
    title,
    message,
    colorText: colorText,
    backgroundColor: backgroundColor,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(8),
  );
}
