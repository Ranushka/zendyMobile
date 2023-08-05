import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:zendy/controllers/controllers.dart';

PreferredSizeWidget emptyAppbar() {
  final AuthController authController = Get.find();

  final isDark = authController.currentUser.value.theme == 'DARK';

  final statusBarColor = isDark ? Colors.black : Colors.white;

  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: statusBarColor),
    backgroundColor: isDark ? Colors.black : Colors.white,
    automaticallyImplyLeading: false,
    toolbarHeight: 0,
    elevation: 0,
  );
}
