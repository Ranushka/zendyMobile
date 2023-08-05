import 'package:flutter/material.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:get/get.dart';
import 'package:zendy/helpers/print_log.dart';
import 'package:zendy/widgets/widgets.dart';

class FrameworkSelect extends StatefulWidget {
  final IconData icon;
  final List<S2Choice<String>> options;
  final String selectedValue;
  final String title;
  final void Function(String)? onChange;

  FrameworkSelect({
    this.title = '',
    this.selectedValue = '',
    this.icon = Icons.language_rounded,
    required this.options,
    this.onChange,
  });

  @override
  _FrameworkSelectState createState() => _FrameworkSelectState();
}

class _FrameworkSelectState extends State<FrameworkSelect> {
  String selectedFramework = '';

  @override
  void initState() {
    super.initState();
    selectedFramework = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    printLog('options', widget.options);

    return SmartSelect<String>.single(
      title: widget.title,
      selectedValue: selectedFramework,
      modalType: S2ModalType.bottomSheet,
      choiceItems: widget.options,
      onChange: (state) {
        setState(() {
          selectedFramework = state.title.toString();
        });
        widget.onChange!(state.value);
      },
      tileBuilder: (context, state) {
        return InkWell(
          onTap: state.showModal,
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
                Title3(state.title!),
                const Spacer(),
                TextBody(state.selected.value),
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
