import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

Future filtersModel() {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
      return const SafeArea(
        child: FractionallySizedBox(
          heightFactor: 0.9,
          child: CheckBoxInListView(),
        ),
      );
    },
  );
}

var titleMap = {
  'journalTitleFull': 'Material Type',
  'subjectsFull': 'Subjects',
  'genlanguage': 'Language',
  'publishersFull': 'Publishers',
  'publicationTypeFull': 'Publication Type'
};

class CheckBoxInListView extends StatefulWidget {
  const CheckBoxInListView({super.key});

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  final SearchResultController searchResultCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget _buildBackButton() {
      return IconButton(
        splashRadius: 28,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        onPressed: () => Get.back(),
      );
    }

    Widget _buildBottomSheet() {
      var resultData = searchResultCtrl.searchResults[0];

      var totalResults = resultData['searchResults']['totalResults'];

      var trCount = NumberFormat.compact().format(
        totalResults,
      );

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.background,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Gutter(Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            TextButton(
              child: const TextBody('Clear filters'),
              onPressed: () {
                searchResultCtrl.clearFiltrs();
                Get.back();
              },
            ),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: TextBody('Show reselts - $trCount'),
            ),
          ],
        )),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      bottomSheet: Obx(() => _buildBottomSheet()),
      appBar: AppBar(
        leadingWidth: 8,
        leading: Container(),
        actions: [_buildBackButton()],
        title: const Title2('Filters'),
      ),
      body: FiltersList(),
    );
  }
}

checkBoxRow(name, count, bool checked, catId) {
  final SearchResultController searchResultCtrl = Get.find();

  RxBool isChecked = checked.obs;
  return Obx(() {
    return CheckboxListTile(
      activeColor: Theme.of(Get.context!).primaryColor,
      title: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [Title3(name), TextBody(' - $count')],
      ),
      value: isChecked.value,
      onChanged: (val) {
        searchResultCtrl.toggleFilterItem(catId, name);
        isChecked.value = val ?? false;
      },
    );
  });
}

class FiltersList extends StatelessWidget {
  final SearchResultController searchResultCtrl = Get.find();

  FiltersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final searchResults = searchResultCtrl.searchResults[0];
      final availableFacets =
          searchResults['searchResults']?['availableFacets'];
      final appliedFacets =
          searchResults['searchRequestCriteria']['appliedFacets'];

      if (availableFacets!.isEmpty) {
        return Container();
      }

      final finalList = <Widget>[];

      for (var availableFacetGroup in availableFacets!) {
        var catId = availableFacetGroup;

        finalList.add(Gutter(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 8),
                child: Title4(catId['categoryLabel']),
              ),
              dividerX
            ],
          ),
        ));

        int indexC = 0;

        for (var availableFacetItem in availableFacetGroup['facets']!) {
          indexC++;

          if (indexC >= 10) break;

          var count = NumberFormat.compact().format(
            availableFacetItem['count'],
          );

          var name = availableFacetItem['facetLabel'];
          var checked = appliedFacets!
              .where((c) =>
                  c['categoryId'] == catId &&
                  c['facetLabel'] == availableFacetItem.facetLabel)
              .toList()
              .isNotEmpty;

          finalList.add(checkBoxRow(name, count, checked, catId));
        }
      }

      return ListView(
        padding: const EdgeInsets.all(8),
        children: finalList,
      );
    });
  }
}

class SimpleModel {
  String title;
  bool isChecked;

  SimpleModel(this.title, this.isChecked);
}
