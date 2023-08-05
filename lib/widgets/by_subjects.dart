import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

class BySubjects extends StatelessWidget {
  final BySubjectsController bySubjectsController = Get.find();

  BySubjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (bySubjectsController.isLoading.value) {
        return _skeleton;
      } else {
        return _buildContent(bySubjectsController.data);
      }
    });
  }
}

const _skeleton = Gutter(
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

Widget _buildContent(data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: 8),
      Gutter(WidgetTitleAction('By subjects', () {})),
      SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 16),
            for (var item in data.value) _buildItem(item),
            const SizedBox(width: 16),
          ],
        ),
      )
    ],
  );
}

Widget _buildItem(itm) {
  if (itm['paragraph'] == '') return Container();

  return SizedBox(
    width: Get.width * 0.6,
    child: Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          if (itm['image'] != false)
            Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(itm['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.orange.withOpacity(0.8),
            child: Center(
              child: Title3(itm['title'], ml: 3),
            ),
          ),
        ],
      ),
    ),
  );
}
