import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

class JoinZendy extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn()) {
        return Container();
      }

      return Gutter(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(Get.context).primaryColorLight,
        ),
        child: Gutter(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Title2('Join Zendy'),
            SizedBox(height: 8),
            TextBody(
                'Create free account and enjoy Zendy plus and the feacthers comes with it.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: TextBody('Learn more'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: TextBody('Create account / Login'),
                  onPressed: () {
                    Get.toNamed(Goto.login);
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        )),
      ));
    });
  }
}
