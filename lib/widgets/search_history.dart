import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SearchHistory extends StatelessWidget {
  final SearchHistoryController searchHistoryController = Get.find();
  final SearchController searchController = Get.find();

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
                onTap: () => searchController.searchAction(_searchText),
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

  return Flex(
    direction: Axis.horizontal,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Icon(FontIcons.history),
      ),
      Expanded(
        flex: 7,
        child: TextBody(searchText),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: IconButton(
          icon: Icon(
            FontIcons.history_reuse,
          ),
          onPressed: () {
            searchController.searchField.text = searchText;
          },
        ),
      ),
    ],
  );
}
