import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';

Widget citationsExportMenu() {
  // final selected = "Bulk action".obs;

  // void setSelected(String value) {
  //   selected.value = value;
  // }

  // return Obx(() {
  return PopupMenuButton(
    icon: Icon(Icons.more_vert),
    itemBuilder: (BuildContext bc) => [
      PopupMenuItem(
        child: Text("Export Selected"),
        value: "/newchat",
      ),
      PopupMenuItem(
        child: Text("Select all"),
        value: "/new-group-chat",
      ),
      PopupMenuItem(
        child: Text("Settings"),
        value: "/settings",
      ),
    ],
    // onSelected: (value) => setSelected(value),
  );
  // });
}
