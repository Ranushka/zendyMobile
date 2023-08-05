import 'package:flutter/material.dart';

import 'package:zendy/widgets/widgets.dart';

Widget citationsExportMenu() {
  return PopupMenuButton(
    icon: const Icon(Icons.more_vert),
    itemBuilder: (BuildContext bc) => [
      const PopupMenuItem(
        value: "/newchat",
        child: TextBody("Export Selected"),
      ),
      const PopupMenuItem(
        value: "/new-group-chat",
        child: TextBody("Select all"),
      ),
      const PopupMenuItem(
        value: "/settings",
        child: TextBody("Settings"),
      ),
    ],
  );
}
