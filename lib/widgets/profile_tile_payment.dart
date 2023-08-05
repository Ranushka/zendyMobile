import 'package:flutter/material.dart';

import 'package:zendy/widgets/widgets.dart';

class ProfileTilePayment extends StatelessWidget {
  final String? title;
  final String? initialValue;
  final List? options;
  final IconData icon;
  final Function? onChange;

  const ProfileTilePayment({
    Key? key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.background,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            const Title3('Subscribed with'),
            const Spacer(),
            const TextSmall('card ending with - 4242'),
            const SizedBox(width: 8),
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
