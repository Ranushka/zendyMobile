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

      return Gutter(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(Get.context!).primaryColorLight,
        ),
        child: Gutter(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Title2('Join Zendy'),
            const SizedBox(height: 8),
            const TextBody(
                'Create free account and enjoy Zendy plus and the feacthers comes with it.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const TextBody('Learn more'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('Create account / Login'),
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
