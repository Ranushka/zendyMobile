import 'package:flutter/material.dart';
import 'package:zendy_app/widgets/typography.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function action;

  const ProfileTile({
    Key key,
    this.title,
    this.subTitle = '',
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.vertical,
              children: [
                Title3(title),
                if (subTitle != '') SmallMute(subTitle),
              ],
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.grey.shade400,
            )
          ],
        ),
      ),
    );
  }
}
