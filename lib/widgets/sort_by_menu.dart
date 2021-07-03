import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';

Widget sortByMenu() {
  final selected = "By relevence".obs;

  void setSelected(String value) {
    selected.value = value;
  }

  return Obx(() {
    return DropdownButton(
      style: TextStyle(color: c.acc1, fontSize: 14),
      underline: Container(),
      value: selected.value,
      itemHeight: 50.0,
      items: [
        DropdownMenuItem(
          value: 'By relevence',
          child: Text('By relevence'),
        ),
        DropdownMenuItem(
          value: 'Newest first',
          child: Text('Newest first'),
        ),
        DropdownMenuItem(
          value: 'Oldest first',
          child: Text('Oldest first'),
        ),
        DropdownMenuItem(
          value: 'Most citations',
          child: Text('Most citations'),
        ),
      ],
      onChanged: (value) => setSelected(value),
    );
  });
}
