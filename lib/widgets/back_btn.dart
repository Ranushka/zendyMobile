import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy_app/widgets/cus_icons.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      icon: Icon(CusIcons.arrow_back),
      onPressed: () => Get.back(),
    );
  }
}
