import 'package:flutter/material.dart';

import 'package:zendy_app/widgets/widgets.dart';

class SwipeDelete extends StatelessWidget {
  final String uniqueId;
  final Widget child;
  final Function onDismissed;

  SwipeDelete({
    @required this.child,
    @required this.uniqueId,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(uniqueId),
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Gutter(
          TextBody('Delete', nigateColor: true),
        ),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: onDismissed,
      child: child,
    );
  }
}
