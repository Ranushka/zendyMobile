import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:zendy_app/helpers/helpers.dart';

class ProfileTileProfession extends StatelessWidget {
  final String title;
  final List initialValue;
  final List options;
  final IconData icon;
  final Function onChange;

  const ProfileTileProfession({
    Key key,
    this.title,
    this.initialValue,
    this.options,
    this.icon = Icons.language_rounded,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect.single(
      title: 'My Role / Profession',
      value: initialValue,
      onChange: (selected) {
        onChange(selected.value);
      },
      choiceType: S2ChoiceType.chips,
      choiceItems: S2Choice.listFrom<String, Map>(
        source: userRolesList,
        value: (index, item) => item['id'],
        title: (index, item) => item['name'],
      ),
      modalConfig: S2ModalConfig(
        type: S2ModalType.bottomSheet,
        useFilter: true,
      ),
      tileBuilder: (context, state) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: S2Tile.fromState(
            state,
            isTwoLine: true,
          ),
        );
      },
    );
  }
}
