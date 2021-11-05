import 'package:flutter/material.dart';
// import 'package:smart_select/smart_select.dart';

// import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';

class ProfileTileInput extends StatelessWidget {
  final String title;
  final String initialValue;
  final List options;
  final IconData icon;
  final Function onChange;

  const ProfileTileInput({
    Key key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: state.showModal,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Theme.of(context).backgroundColor,
        child: Flex(
          direction: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Colors.grey.shade500,
            ),
            SizedBox(width: 16),
            // Title3(title),
            SizedBox(
              child: Title3(title),
              width: MediaQuery.of(context).size.width * 0.20,
            ),
            SizedBox(width: 16),
            // Spacer(),
            TextBody(initialValue.toString()),
            SizedBox(width: 8),
            // Icon(
            //   Icons.keyboard_arrow_right_rounded,
            //   color: Colors.grey.shade400,
            // )
          ],
        ),
      ),
    );
  }
}
