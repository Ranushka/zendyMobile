import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

Widget bottomNavigation() {
  final RxInt curIn = 0.obs;
  final AuthController authCtrl = Get.find();

  Widget btnReguler(String name, IconData icon, onClick) {
    final isActive = Get.currentRoute == name;
    final pc = Theme.of(Get.context!).primaryColor;
    final sc = Theme.of(Get.context!).hintColor;

    return Expanded(
      flex: 1,
      child: Material(
        color: Theme.of(Get.context!).colorScheme.background,
        child: IconButton(
          highlightColor: Theme.of(Get.context!).primaryColorLight,
          color: isActive ? pc : sc,
          iconSize: 24,
          icon: Icon(icon),
          onPressed: onClick,
        ),
      ),
    );
  }

  Widget btnSearch(String name, IconData icon, onClick) {
    return Expanded(
      flex: 1,
      child: Transform.translate(
        offset: const Offset(0, -16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(Get.context!).primaryColor.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 3,
              ),
            ],
            color: Theme.of(Get.context!).primaryColor,
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
      color: Theme.of(Get.context!).colorScheme.background,
      boxShadow: [
        BoxShadow(
          color: Theme.of(Get.context!).primaryColor.withOpacity(0.4),
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
              FontIcons.home,
              () {
                curIn.value = 0;
                Get.toNamed(Goto.home);
              },
            ),
            btnReguler(
              Goto.searches,
              FontIcons.saved_search,
              () {
                curIn.value = 2;
                if (authCtrl.isLoggedIn()) {
                  Get.toNamed(Goto.searches);
                } else {
                  Get.toNamed(Goto.login);
                }
              },
            ),
            btnSearch(
              Goto.search,
              FontIcons.search,
              () {
                curIn.value = 1;
                Get.toNamed(Goto.search);
              },
            ),
            btnReguler(
              Goto.citations,
              FontIcons.my_library,
              () {
                curIn.value = 3;
                if (authCtrl.isLoggedIn()) {
                  Get.toNamed(Goto.citations);
                } else {
                  Get.toNamed(Goto.login);
                }
              },
            ),
            btnReguler(
              Goto.profile,
              FontIcons.user,
              () {
                curIn.value = 4;
                Get.toNamed(Goto.profile);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
