import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';

import 'package:zendy/helpers/helpers.dart';

class ProfileTileProfession extends StatelessWidget {
  final String? title;
  final List? initialValue;
  final List? options;
  final IconData icon;
  final Function onChange;

  const ProfileTileProfession({
    Key? key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
    this.onChange = _defaultOnChange,
  }) : super(key: key);

  static void _defaultOnChange(List<dynamic> value) {}

  @override
  Widget build(BuildContext context) {
    return SmartSelect.single(
      title: 'My Role / Profession',
      selectedValue: initialValue,
      onChange: (selected) {
        onChange(selected.value);
      },
      choiceType: S2ChoiceType.chips,
      choiceItems: S2Choice.listFrom<String, Map>(
        source: userRolesList,
        value: (index, item) => item['id'],
        title: (index, item) => item['name'],
      ),
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
        useFilter: true,
      ),
      tileBuilder: (context, state) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: S2Tile.fromState(
            state,
            isTwoLine: true,
          ),
        );
      },
    );
  }
}
