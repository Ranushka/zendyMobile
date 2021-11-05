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
    backgroundColor = Colors.red[200];
  }

  if (type == MsgType.Success) {
    title = 'Success';
    backgroundColor = Colors.green[200];
  }

  Get.snackbar(
    title,
    message,
    colorText: Colors.black.withOpacity(0.6),
    backgroundColor: backgroundColor,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(8),
  );
}
