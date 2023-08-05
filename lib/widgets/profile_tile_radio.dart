import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy/widgets/widgets.dart';

class ProfileTileRadio extends StatefulWidget {
  const ProfileTileRadio({
    Key? key,
    this.title,
    this.initialValue,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  final String? title;
  final bool? initialValue;
  final IconData icon;
  final Function? onChange;

  @override
  _ProfileTileRadioState createState() => _ProfileTileRadioState();
}

class _ProfileTileRadioState extends State<ProfileTileRadio> {
  bool _initialValue = false;

  @override
  void initState() {
    _initialValue = widget.initialValue ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(Get.context!).colorScheme.background,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.icon,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 16),
            Title3(widget.title ?? ''),
            const Spacer(),
            Switch(
              value: _initialValue,
              onChanged: (value) {
                setState(() {
                  _initialValue = !_initialValue;
                });
              },
              activeTrackColor: Colors.yellow,
              activeColor: Colors.orangeAccent,
            )
          ],
        ),
      ),
    );
  }
}
