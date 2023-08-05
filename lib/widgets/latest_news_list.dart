import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/screens/screens.dart';
import 'package:zendy/screens/web_view_exp.dart';
import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

class LatestNewsList extends StatelessWidget {
  final FeaturedContentController featuredContentController = Get.find();

  LatestNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (featuredContentController.isLoading.value) {
        return _skeleton;
      } else {
        return _newsContent(featuredContentController.data);
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

Widget _newsContent(data) {
  return Gutter(Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Title4('Curated just for you'),
      ),
      for (var item in data.value) _buildLatustNews(item)
    ],
  ));
}

Widget _buildLatustNews(itm) {
  if (itm['paragraph'] == '') return Container();
  var url = itm['url'];

  final webUrl =
      'https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1000387';

  return InkWell(
    onTap: () => {
      Get.to(WebViewExp(url: webUrl, showAppbar: true)),
    },
    child: Card(
      color: Theme.of(Get.context!).colorScheme.background,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
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
                  const SizedBox(height: 4),
                  Title3(itm['title']),
                  const SizedBox(height: 4),
                  TextBody(
                    itm['paragraph'],
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
