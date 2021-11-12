import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy_app/widgets/font_icons.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      icon: Icon(
        FontIcons.arrow_back,
        color: Theme.of(Get.context).primaryColor,
      ),
      onPressed: () => Get.back(),
    );
  }
}
