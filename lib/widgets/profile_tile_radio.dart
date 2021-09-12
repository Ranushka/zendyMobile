import 'package:flutter/material.dart';
import 'package:zendy_app/widgets/widgets.dart';

class ProfileTileRadio extends StatefulWidget {
  ProfileTileRadio({
    Key key,
    this.title,
    this.initialValue,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  final String title;
  final bool initialValue;
  final IconData icon;
  final Function onChange;

  @override
  _ProfileTileRadioState createState() => _ProfileTileRadioState();
}

class _ProfileTileRadioState extends State<ProfileTileRadio> {
  bool _initialValue = false;

  @override
  void initState() {
    _initialValue = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.icon,
              color: Colors.grey.shade500,
            ),
            SizedBox(width: 16),
            Title3(widget.title),
            Spacer(),
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
