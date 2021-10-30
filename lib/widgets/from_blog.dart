import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

class FromBlog extends StatelessWidget {
  final FeaturedContentController featuredContentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (featuredContentController.isLoading.value)
        return _skeleton;
      else
        return _buildContent(featuredContentController.data);
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
      Gutter(WidgetTitleAction('From our blog', () {})),
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
    width: Get.width * 0.8,
    child: Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_itm['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Title3(_itm['title'], ml: 3),
                SizedBox(height: 8),
                TextBody(_itm['paragraph'], ml: 4)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
