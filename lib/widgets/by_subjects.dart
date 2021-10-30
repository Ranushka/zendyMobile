import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

class BySubjects extends StatelessWidget {
  final BySubjectsController bySubjectsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (bySubjectsController.isLoading.value)
        return _skeleton;
      else
        return _buildContent(bySubjectsController.data);
    });
  }
}

final _skeleton = Gutter(
  Column(
    children: [
      Skeleton(),
      SizedBox(height: 8),
      Skeleton(),
      SizedBox(height: 8),
      Skeleton(),
      SizedBox(height: 8),
    ],
  ),
);

Widget _buildContent(_data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(height: 8),
      Gutter(WidgetTitleAction('By subjects', () {})),
      SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 16),
            for (var item in _data.value) _buildItem(item),
            SizedBox(width: 16),
          ],
        ),
      )
    ],
  );
}

Widget _buildItem(_itm) {
  if (_itm['paragraph'] == '') return Container();

  return Container(
    width: Get.width * 0.6,
    child: Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_itm['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Colors.orange.withOpacity(0.8),
            child: Center(
              child: Title3(_itm['title'], ml: 3),
            ),
          ),
        ],
      ),
    ),
  );
}
