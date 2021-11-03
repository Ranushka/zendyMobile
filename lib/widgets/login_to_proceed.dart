import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';

loginToProceed() {
  Get.defaultDialog(
    backgroundColor: Theme.of(Get.context).primaryColorLight,
    middleTextStyle: Theme.of(Get.context).textTheme.bodyText1,
    titleStyle: Theme.of(Get.context).textTheme.headline2,
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
