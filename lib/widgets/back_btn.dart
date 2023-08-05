import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy/widgets/font_icons.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      icon: Icon(
        FontIcons.arrow_back,
        color: Theme.of(Get.context!).primaryColor,
      ),
      onPressed: () => Get.back(),
    );
  }
}
