import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/helpers/helpers.dart';

Future citeModel(_id, title) {
  // var _internalLink = Goto.title + _id;
  return showModalBottomSheet(
    context: Get.context,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            citeItem(title, _id),
            citeItem(title, _id),
            citeItem(title, _id),
          ],
        ),
      );
    },
  );
}

Widget citeItem(title, _id) {
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
            Get.toNamed(Goto.title, arguments: _id);
          },
        ),
      ),
    ),
  );
}
