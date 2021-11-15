import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';
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
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Title4('Curated just for you'),
      ),
      for (var item in _data.value) _buildLatustNews(item)
    ],
  ));
}

Widget _buildLatustNews(_itm) {
  if (_itm['paragraph'] == '') return Container();
  var _url = _itm['url'];

  return InkWell(
    onTap: () => goToWebPage("", _url),
    child: Card(
      color: Theme.of(Get.context).backgroundColor,
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
                  TextSmall('Elsevier - Journal'.toUpperCase()),
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
    ),
  );
}
