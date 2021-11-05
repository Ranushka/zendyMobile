import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

Widget bottomNavigation() {
  final RxInt _curIn = 0.obs;
  final AuthController authCtrl = Get.find();

  Widget btnReguler(String name, IconData icon, onClick) {
    final isActive = Get.currentRoute == name;
    final pc = Theme.of(Get.context).primaryColor;
    final sc = Theme.of(Get.context).hintColor;

    return Expanded(
      flex: 1,
      child: Material(
        color: Theme.of(Get.context).backgroundColor,
        child: IconButton(
          highlightColor: Theme.of(Get.context).primaryColorLight,
          color: isActive ? pc : sc,
          iconSize: 24,
          icon: Icon(icon),
          onPressed: onClick,
        ),
      ),
    );
  }

  Widget btnSearch(String name, IconData icon, onClick) {
    // final isActive = Get.currentRoute == Goto.searchResult;
    // final pc = Theme.of(Get.context).primaryColor;
    // // final sc = Theme.of(Get.context).hintColor.withOpacity(0.3);
    // final sc = Theme.of(Get.context).hintColor;

    return Expanded(
      flex: 1,
      child: Transform.translate(
        offset: const Offset(0, -16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(Get.context).primaryColor.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 3,
              ),
            ],
            color: Theme.of(Get.context).primaryColor,
            borderRadius: BorderRadius.circular(200),
          ),
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              highlightColor: Colors.transparent,
              color: Colors.white,
              icon: Icon(
                icon,
                size: 28,
              ),
              onPressed: onClick,
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(Get.context).backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(Get.context).primaryColor.withOpacity(0.4),
          spreadRadius: 2,
          blurRadius: 3,
        ),
      ],
    ),
    child: SafeArea(
      bottom: true,
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            btnReguler(
              Goto.home,
              CusIcons.home,
              () {
                _curIn.value = 0;
                Get.toNamed(Goto.home);
              },
            ),
            btnReguler(
              Goto.searches,
              CusIcons.saved_search,
              () {
                _curIn.value = 2;
                if (authCtrl.isLoggedIn()) {
                  Get.toNamed(Goto.searches);
                } else {
                  Get.toNamed(Goto.login);
                }
              },
            ),
            btnSearch(
              Goto.search,
              CusIcons.search,
              () {
                _curIn.value = 1;
                Get.toNamed(Goto.search);
              },
            ),
            btnReguler(
              Goto.citations,
              CusIcons.my_library,
              () {
                _curIn.value = 3;
                if (authCtrl.isLoggedIn()) {
                  Get.toNamed(Goto.citations);
                } else {
                  Get.toNamed(Goto.login);
                }
              },
            ),
            btnReguler(
              Goto.profile,
              CusIcons.user,
              () {
                _curIn.value = 4;
                Get.toNamed(Goto.profile);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
