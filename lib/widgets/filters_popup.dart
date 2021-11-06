import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

Future filtersModel() {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
      return SafeArea(
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
  CheckBoxInListView();

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  @override
  Widget build(BuildContext context) {
    Widget _buildBackButton() {
      return IconButton(
        splashRadius: 28,
        icon: Icon(Icons.arrow_drop_down_circle_outlined),
        onPressed: () => Get.back(),
      );
    }

    Widget _buildBottomSheet() {
      final SearchResultController searchResultCtrl = Get.find();

      var totalResults = NumberFormat.compact().format(
        searchResultCtrl.searchResults.value.data.searchResults.totalResults,
      );

      return Container(
        child: Gutter(Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            TextButton(
              child: TextBody('Clear filters'),
              onPressed: () {
                searchResultCtrl.clearFiltrs();
                Get.back();
              },
            ),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: TextBody('Show reselts - ' + totalResults),
            ),
          ],
        )),
        decoration: BoxDecoration(
          color: Theme.of(Get.context).backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      bottomSheet: Obx(() => _buildBottomSheet()),
      appBar: AppBar(
        leadingWidth: 8,
        leading: Container(),
        actions: [_buildBackButton()],
        title: Title2('Filters'),
      ),
      body: FiltersList(),
    );
  }
}

checkBoxRow(name, count, bool checked, catId) {
  final SearchResultController searchResultCtrl = Get.find();

  RxBool _isChecked = checked.obs;
  return Obx(() {
    return CheckboxListTile(
      activeColor: Theme.of(Get.context).primaryColor,
      title: Wrap(
        direction: Axis.horizontal,
        children: [TextBody(name + ' - $count')],
      ),
      value: _isChecked.value,
      onChanged: (bool val) {
        searchResultCtrl.toggleFilterItem(catId, name);
        _isChecked.value = val;
      },
    );
  });
}

class FiltersList extends StatelessWidget {
  final SearchResultController searchResultCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var availableFacets = searchResultCtrl
          .searchResults.value.data.searchResults.availableFacets;
      var appliedFacets = searchResultCtrl
          .searchResults.value.data.searchRequestCriteria.appliedFacets;

      if (availableFacets.length == 0) {
        return Container();
      }

      final finalList = <Widget>[];

      for (var availableFacetGroup in availableFacets) {
        var catId = availableFacetGroup.categoryId;

        finalList.add(Gutter(
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 32, 0, 8),
                child: Title4(titleMap[catId]),
              ),
              dividerX
            ],
          ),
        ));

        int _indexC = 0;

        for (var availableFacetItem in availableFacetGroup.facets) {
          _indexC++;

          if (_indexC >= 10) break;

          var count = availableFacetItem.count.toString();
          var name = availableFacetItem.facetLabel.toString();
          var checked = appliedFacets
                  .where((c) =>
                      c['categoryId'] == catId &&
                      c['facetLabel'] == availableFacetItem.facetLabel)
                  .toList()
                  .length !=
              0;

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
