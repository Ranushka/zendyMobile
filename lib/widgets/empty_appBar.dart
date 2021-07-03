import 'package:flutter/material.dart';

// class EmptyAppbar extends StatelessWidget {
//   @override
//   PreferredSizeWidget build(BuildContext context) {
//     return AppBar(
//       brightness: Brightness.light,
//       automaticallyImplyLeading: false,
//       toolbarHeight: 0,
//       elevation: 0,
//     );
//   }
// }

PreferredSizeWidget emptyAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    automaticallyImplyLeading: false,
    toolbarHeight: 0,
    elevation: 0,
  );
}
