import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

class FromBlog extends StatelessWidget {
  final FeaturedContentController featuredContentController = Get.find();

  FromBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (featuredContentController.isLoading.value) {
        return _skeleton;
      } else {
        return _buildContent(featuredContentController.data);
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
      Gutter(WidgetTitleAction('From our blog', () {})),
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
    width: Get.width * 0.8,
    child: Card(
      color: Theme.of(Get.context!).colorScheme.background,
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(itm['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Title3(itm['title'], ml: 3),
                const SizedBox(height: 8),
                TextBody(itm['paragraph'], ml: 4)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
