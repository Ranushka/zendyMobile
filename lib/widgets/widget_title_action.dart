import 'package:flutter/material.dart';
import 'package:zendy_app/widgets/typography.dart';

class WidgetTitleAction extends StatelessWidget {
  final String _text;
  final Function _action;
  const WidgetTitleAction(this._text, this._action);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Title4(_text),
        TextButton(
          onPressed: _action as void Function(),
          child: Text('Read more'),
        )
      ],
    );
  }
}
