import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SearchHistory extends StatelessWidget {
  final SearchHistoryController searchHistoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: searchHistoryController.getData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data.toString() == 'null') {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: TextBody('Something went wrong'));
          }

          if (snapshot.data.docs.length < 1) {
            return Center(child: TextBody('Start searching...'));
          }

          return ListView.builder(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.size,
            itemBuilder: (context, index) {
              final _data = snapshot.data.docs[index];
              final _searchText = _data['query'];

              return SwipeDelete(
                uniqueId: _data.id,
                onDismissed: (direction) {
                  searchHistoryController.deleteData(_data.id);
                },
                child: _buildHistoryItem(_searchText),
              );
            },
          );
        },
      ),
    );
  }
}

_buildHistoryItem(searchText) {
  final SearchController searchController = Get.find();

  return InkWell(
    onTap: () => _searchAction(searchText),
    child: Flex(
      direction: Axis.vertical,
      children: [
        Gutter(Flex(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Icon(CusIcons.history),
            ),
            Expanded(
              flex: 7,
              child: TextBody(searchText),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: IconButton(
                icon: Icon(
                  CusIcons.history_reuse,
                ),
                onPressed: () {
                  searchController.searchField.text = searchText;
                },
              ),
            ),
          ],
        )),
        dividerX
      ],
    ),
  );
}

void _searchAction(value) {
  final SearchResultController srCtrl = Get.find();
  final SearchHistoryController shCtrl = Get.find();

  if (value == null) return;
  if (value == '') return;

  srCtrl.searchQry.value = value;
  srCtrl.clearCtrl();
  srCtrl.searchResultsGet();
  shCtrl.createData(value);

  Get.offNamed(Goto.searchResult);
}
