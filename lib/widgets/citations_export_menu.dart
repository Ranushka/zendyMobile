import 'package:flutter/material.dart';

import 'package:zendy_app/widgets/widgets.dart';

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
        child: TextBody("Export Selected"),
        value: "/newchat",
      ),
      PopupMenuItem(
        child: TextBody("Select all"),
        value: "/new-group-chat",
      ),
      PopupMenuItem(
        child: TextBody("Settings"),
        value: "/settings",
      ),
    ],
    // onSelected: (value) => setSelected(value),
  );
  // });
}
