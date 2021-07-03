import 'package:flutter/material.dart';
// import 'package:smart_select/smart_select.dart';

// import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';

class ProfileTilePaymentHistory extends StatelessWidget {
  final String title;
  final String initialValue;
  final List options;
  final IconData icon;
  final Function onChange;

  const ProfileTilePaymentHistory({
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
        color: Colors.white,
        child: Flex(
          direction: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Title3('Paymnet history'),
            Spacer(),
            SmallMute('Last payment 2 days ago'),
            SizedBox(width: 8),
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
