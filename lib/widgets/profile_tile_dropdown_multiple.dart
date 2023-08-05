import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:zendy/widgets/widgets.dart';

class ProfileTileDropdownMultiple extends StatelessWidget {
  final String? title;
  final List<Object?>? initialValue;
  final List<S2Choice<Object?>>? options;
  final IconData? icon;
  final void Function(S2MultiSelected?)? onChange;

  const ProfileTileDropdownMultiple({
    Key? key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect.multiple(
      title: title,
      selectedValue: initialValue!,
      choiceItems: options,
      modalType: S2ModalType.bottomSheet,
      onChange: (selected) {
        onChange!(selected);
      },
      tileBuilder: (context, state) {
        return InkWell(
          onTap: state.showModal,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 16),
                Title3(state.title!),
                const Spacer(),
                TextSmall(state.toString()),
                const SizedBox(width: 8),
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
