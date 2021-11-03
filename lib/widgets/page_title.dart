import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy_app/widgets/typography.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key key,
    this.text,
    this.icon = Icons.logout,
    this.action,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      color: Theme.of(Get.context).backgroundColor,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          Title1(text),
          action,
        ],
      ),
    );
  }
}
