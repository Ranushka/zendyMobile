import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

class SearchHistory extends StatelessWidget {
  final SearchHistoryController searchHistoryController = Get.find();
  final CustomSearchController searchController = Get.find();

  SearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: searchHistoryController.getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: TextBody('Something went wrong'));
          }

          if (snapshot.data.isEmpty) {
            return const Gutter(Center(
              child: TextBody(
                'Add Search results to your library will help you to read or export later',
              ),
            ));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var providedDataString = snapshot.data[index];
              var _rowId = snapshot.data[index]['id'].toString();
              final searchText = providedDataString['data'].replaceAll('"', '');

              return SwipeDelete(
                uniqueId: _rowId,
                onTap: () => searchController.searchAction(searchText),
                onDismissed: (direction) {
                  searchHistoryController.deleteData(_rowId);
                },
                child: _buildHistoryItem(searchText),
              );
            },
          );
        },
      ),
    );
  }
}

_buildHistoryItem(searchText) {
  final CustomSearchController searchController = Get.find();

  return Flex(
    direction: Axis.horizontal,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Icon(FontIcons.history),
      ),
      Expanded(
        flex: 7,
        child: TextBody(searchText),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: IconButton(
          icon: const Icon(
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
