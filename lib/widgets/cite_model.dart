import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/helpers/helpers.dart';

Future citeModel(id, title) {
  return showModalBottomSheet(
    context: Get.context!,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            citeItem(title, id),
            citeItem(title, id),
            citeItem(title, id),
          ],
        ),
      );
    },
  );
}

Widget citeItem(title, id) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          highlightColor: Colors.transparent,
          splashColor: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.only(right: 4, bottom: 4),
            child: TextBody(title.trim(), link: true),
          ),
          onTap: () {
            Get.toNamed(Goto.title, arguments: id);
          },
        ),
      ),
    ),
  );
}
