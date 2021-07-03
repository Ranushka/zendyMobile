import 'package:flutter/material.dart';
// import 'package:smart_select/smart_select.dart';

// import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';

class ProfileTilePayment extends StatelessWidget {
  final String title;
  final String initialValue;
  final List options;
  final IconData icon;
  final Function onChange;

  const ProfileTilePayment({
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
            // Icon(
            //   Icons.payment_outlined,
            //   color: Colors.grey.shade500,
            // ),
            // SizedBox(width: 16),
            // Title3(title),
            Title3('Subscribed with'),
            // SizedBox(
            //   child: Title3('Current payment plan'),
            //   width: MediaQuery.of(context).size.width * 0.20,
            // ),
            // SizedBox(width: 16),
            Spacer(),
            SmallMute('card ending with - 4242'),
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
