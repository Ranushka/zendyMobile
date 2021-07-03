import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:zendy_app/widgets/widgets.dart';

class ProfileTileDropdown extends StatelessWidget {
  final String title;
  final String initialValue;
  final List options;
  final IconData icon;
  final Function onChange;

  const ProfileTileDropdown({
    Key key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.single(
      title: title,
      value: initialValue,
      choiceItems: options,
      modalType: S2ModalType.bottomSheet,
      onChange: (selected) {
        onChange(selected);
      },
      tileBuilder: (context, state) {
        return InkWell(
          onTap: state.showModal,
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.grey.shade500,
                ),
                SizedBox(width: 16),
                Title3(state.title),
                Spacer(),
                SmallMute(state.valueTitle.toString()),
                SizedBox(width: 8),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.grey.shade400,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
