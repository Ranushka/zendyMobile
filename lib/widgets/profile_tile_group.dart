import 'package:flutter/material.dart';
import 'package:zendy_app/widgets/typography.dart';

class ProfileTileGroup extends StatelessWidget {
  final String title;
  final Widget content;

  const ProfileTileGroup({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      direction: Axis.vertical,
      children: [
        SizedBox(height: 32),
        Gutter(SmallMute(title)),
        SizedBox(height: 8),
        content,
      ],
    );
  }
}
