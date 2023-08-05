import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MsgType { Success, Error, Default }

void showSnackbar({
  MsgType type = MsgType.Default,
  String message = '',
}) {
  String title = 'Hmmm';
  Color backgroundColor = Colors.black54;

  if (type == MsgType.Error) {
    title = 'Opps...';
    backgroundColor = Colors.green;
  }

  if (type == MsgType.Success) {
    title = 'Success';
    backgroundColor = Colors.green;
  }

  Get.snackbar(
    title,
    message,
    colorText: Colors.black.withOpacity(0.6),
    backgroundColor: backgroundColor,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(8),
  );
}
