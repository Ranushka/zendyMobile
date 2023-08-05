import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';

loginToProceed() {
  Get.defaultDialog(
    backgroundColor: Theme.of(Get.context!).primaryColorLight,
    middleTextStyle: Theme.of(Get.context!).textTheme.bodyLarge,
    titleStyle: Theme.of(Get.context!).textTheme.displayMedium,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    radius: 8,
    title: 'Join Zendy',
    middleText:
        'Please login or crate account to download or read full article.',
    actions: [
      ElevatedButton(
        child: const Text('Create account / Login'),
        onPressed: () {
          Get.back();
          Get.toNamed(Goto.login);
        },
      )
    ],
  );
}
