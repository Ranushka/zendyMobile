import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

class JoinZendy extends StatelessWidget {
  final AuthController authController = Get.find();

  JoinZendy({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn()) {
        return Container();
      }

      final isDark = authController.currentUser.value.theme == 'DARK';

      return Gutter(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: !isDark
              ? Theme.of(Get.context!).primaryColorLight
              : Theme.of(Get.context!).primaryColorDark,
        ),
        child: Gutter(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Title2('Join Zendy'),
            const SizedBox(height: 8),
            const TextBody(
                'Sign up for a free account to experience personalized and curated content exclusively tailored to your preferences, with expert insights into your selected areas.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SizedBox()),
                ElevatedButton(
                  child: const Text(
                    'Create account / Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Get.toNamed(Goto.login);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        )),
      ));
    });
  }
}
