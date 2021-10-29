import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

class LatestNewsList extends StatelessWidget {
  final FeaturedContentController featuredContentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (featuredContentController.isLoading.value)
        return _skeleton;
      else
        return _newsContent(featuredContentController.data);
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

Widget _newsContent(_data) {
  return Gutter(Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      WidgetTitleAction('Curated just for you', () {}),
      for (var item in _data.value) _buildLatustNews(item)
    ],
  ));
}

Widget _buildLatustNews(_itm) {
  if (_itm['paragraph'] == '') return Container();

  return Card(
    elevation: 0,
    margin: EdgeInsets.only(bottom: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Title5('Elsevier - Journal'),
                SizedBox(height: 4),
                Title3(_itm['title']),
                SizedBox(height: 4),
                TextBody(
                  _itm['paragraph'],
                  ml: 2,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}