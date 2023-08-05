import 'package:flutter/material.dart';

import 'package:zendy/widgets/widgets.dart';

class SwipeDelete extends StatelessWidget {
  final String uniqueId;
  final Widget child;
  final void Function(dynamic action)? onDismissed;
  final Function()? onTap;

  const SwipeDelete({
    required this.child,
    required this.uniqueId,
    required this.onDismissed,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(uniqueId),
      behavior: HitTestBehavior.opaque,
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: const Gutter(
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
