import 'dart:convert';
import "package:intl/intl.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';

class SavedSearchersScreen extends StatelessWidget {
  const SavedSearchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(),
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildMainContent() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        PageTitle(
          text: 'Searchers',
          icon: Icons.logout,
          action: citationsExportMenu(),
        ),
        _buildlist()
      ],
    );
  }

  Widget _buildlist() {
    return Expanded(
      child: _content(),
    );
  }
}

Widget _content() {
  final CustomSearchController searchController = Get.find();

  return StreamBuilder(
    stream: SavedSearchersController().getData(),
    builder: (BuildContext context, snapshot) {
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
          var _row = snapshot.data[index];
          var _rowId = _row['id'].toString();
          Map<String, dynamic> _item = json.decode(_row['data']);

          var sortByText = 'Sort by - ${_item['sort']}';
          var filterByText = 'filterd by ${_item['filters']}';
          var _keyword = _item['keyword'];
          var _resultsCountFormated = NumberFormat.compact().format(
            _item['count'],
          );
          var _count = " - ${_resultsCountFormated} results";

          var buildItem = Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Title2(_keyword), TextSmall(_count)],
              ),
              const SizedBox(height: 4),
              TextBody("$sortByText and $filterByText"),
              const SizedBox(height: 16),
            ],
          );

          return SwipeDelete(
            uniqueId: _rowId,
            onTap: () {
              searchController.searchAction(_item['keyword']);
            },
            child: buildItem,
            onDismissed: (action) {
              SavedSearchersController().deleteData(_rowId);
            },
          );
        },
      );
    },
  );
}

Widget buildListTile(item) {
  print(item['keyword']);
  return const ListTile(
    title: Title3('item.keyword'),
    subtitle: Title3('item.filters'),
  );
}
