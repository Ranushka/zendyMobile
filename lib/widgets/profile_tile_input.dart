import 'package:flutter/material.dart';

import 'package:zendy/widgets/widgets.dart';

class ProfileTileInput extends StatelessWidget {
  final String? title;
  final String? initialValue;
  final List? options;
  final IconData icon;

  const ProfileTileInput({
    Key? key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
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
            Icon(
              icon,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.20,
              child: Title3(title.toString()),
            ),
            const SizedBox(width: 16),
            TextBody(initialValue.toString()),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
