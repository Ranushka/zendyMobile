import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy/helpers/helpers.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

Widget CusBackButton() {
  return IconButton(
    splashRadius: 24,
    icon: const Icon(FontIcons.arrow_back),
    onPressed: () => Get.back(),
  );
}

Widget AppBarLogo({showBackBtn = false}) {
  final AuthController authController = Get.find();

  final String? firstName = authController.currentUser.value.firstName;

  final Widget greetingWidget = firstName != null
      ? TextBody('G, day $firstName')
      : TextButton(
          onPressed: () => Get.toNamed(Goto.notification),
          child: const Text('Join Zendy'),
        );

  return Gutter(
    Flex(
      direction: Axis.horizontal,
      children: [
        if (showBackBtn) ...[
          Transform.translate(offset: Offset(-16, 0), child: CusBackButton())
        ],
        Transform.translate(
          offset: Offset(showBackBtn ? -16 : 0, 0),
          child: getLogoImg(120),
        ),
        Expanded(child: SizedBox()),
        greetingWidget,
        IconButton(
          onPressed: () => Get.toNamed(Goto.notification),
          icon: Icon(Icons.notifications),
        ),
      ],
    ),
  );
}
