import 'package:flutter/material.dart';

import 'package:zendy_app/widgets/widgets.dart';

class SwipeDelete extends StatelessWidget {
  final String uniqueId;
  final Widget child;
  final Function onDismissed;
  final Function onTap;

  SwipeDelete({
    @required this.child,
    @required this.uniqueId,
    @required this.onDismissed,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(uniqueId),
      behavior: HitTestBehavior.opaque,
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Gutter(
          TextBody('Delete', nigateColor: true),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: onDismissed,
      child: InkWell(
        onTap: onTap,
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [Gutter(child), dividerX],
        ),
      ),
    );
  }
}
