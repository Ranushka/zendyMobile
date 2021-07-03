// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/helpers/helpers.dart';

Widget bottomNavigation() {
  final RxInt _curIn = 0.obs;

  Widget iconDat(String name, IconData icon, onClick) {
    final isActive = Get.currentRoute == name;
    final pc = Theme.of(Get.context).primaryColor;
    final sc = Theme.of(Get.context).accentColor.withOpacity(0.3);

    return Expanded(
      flex: 1,
      child: Material(
        color: Theme.of(Get.context).primaryColorLight,
        child: IconButton(
          highlightColor: c.primaryLight,
          color: isActive ? pc : sc,
          iconSize: 24,
          icon: Icon(icon),
          onPressed: onClick,
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: Theme.of(Get.context).primaryColorLight,
      boxShadow: [
        BoxShadow(
          color: Theme.of(Get.context).primaryColor.withOpacity(0.4),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ],
    ),
    child: SafeArea(
      bottom: true,
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            iconDat(
              Goto.home,
              CusIcons.home,
              () {
                _curIn.value = 0;
                Get.toNamed(Goto.home);
              },
            ),
            iconDat(
              Goto.searches,
              CusIcons.searches,
              () {
                _curIn.value = 2;
                Get.toNamed(Goto.searches);
              },
            ),
            iconDat(
              Goto.search,
              CusIcons.search,
              () {
                _curIn.value = 1;
                Get.toNamed(Goto.search);
              },
            ),
            iconDat(
              Goto.citations,
              CusIcons.cite,
              () {
                _curIn.value = 3;
                Get.toNamed(Goto.citations);
              },
            ),
            iconDat(
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

  // return BottomNavigationBar(
  //   type: BottomNavigationBarType.fixed,
  //   // showUnselectedLabels: true,
  //   selectedFontSize: 14,
  //   onTap: onTabTapped, // new
  //   currentIndex: _curIn.value,
  //   items: [
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.home),
  //       label: 'Home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.business),
  //       label: 'Business',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.school),
  //       label: 'School',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.settings),
  //       label: 'Settings',
  //     ),
  //   ],
  //   // currentIndex: _selectedIndex,
  //   selectedItemColor: Colors.amber[800],
  //   // onTap: _onItemTapped,
  // );
}
