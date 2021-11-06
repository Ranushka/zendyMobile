import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

citationPopup() {
  Get.defaultDialog(
    backgroundColor: Theme.of(Get.context).primaryColorLight,
    middleTextStyle: Theme.of(Get.context).textTheme.bodyText1,
    titleStyle: Theme.of(Get.context).textTheme.headline2,
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    radius: 8,
    title: 'Citation',
    middleText:
        'Sho Nakakubo, Masaru Suzuki, Keisuke Kamada, Yu Yamashita, Junichi Nakamura, Hiroshi Horii, … Satoshi Konno. (2020). Proposal of COVID-19 Clinical Risk Score for the management of suspected COVID-19 cases: a case control study. BMC Infectious Diseases, 20. https://doi.org/10.1186/s12879-020-05604-4',
  );
}
