import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy_app/widgets/typography.dart';

Widget sortByMenu() {
  final selected = "By relevence".obs;

  void setSelected(String value) {
    selected.value = value;
  }

  return Obx(() {
    return DropdownButton(
      underline: Container(),
      value: selected.value,
      itemHeight: 50.0,
      items: [
        DropdownMenuItem(
          value: 'By relevence',
          child: TextBody('By relevence'),
        ),
        DropdownMenuItem(
          value: 'Newest first',
          child: TextBody('Newest first'),
        ),
        DropdownMenuItem(
          value: 'Oldest first',
          child: TextBody('Oldest first'),
        ),
        DropdownMenuItem(
          value: 'Most citations',
          child: TextBody('Most citations'),
        ),
      ],
      onChanged: (value) => setSelected(value),
    );
  });
}
