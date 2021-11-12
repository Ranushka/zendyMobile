import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SavedSearchersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(),
      backgroundColor: Theme.of(Get.context).backgroundColor,
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
      children: [
        PageTitle(
          text: 'Searchers',
          icon: Icons.logout,
          action: citationsExportMenu(),
        ),
        _buildlist()
      ],
      direction: Axis.vertical,
    );
  }

  Widget _buildlist() {
    return Expanded(
      child: _content(),
    );
  }
}

Widget _content() {
  final SearchController searchController = Get.find();

  return StreamBuilder(
    stream: SavedSearchersController().getData(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.data.toString() == 'null') {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: TextBody('Something went wrong'));
      }

      if (snapshot.data.docs.length < 1) {
        return Gutter(Center(
          child: TextBody(
            'Save your search use it later and you you can get updates relate to it',
          ),
        ));
      }

      return ListView.builder(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.size,
        itemBuilder: (context, index) {
          var item = snapshot.data.docs[index];
          var _sortByText = 'Sort by - ${item['sort']}';
          var _filterByText = 'filterd by ${item['filters']}';

          var _buildItem = Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Title3(item['keyword']),
                  TextSmall(" - ${item['count']} results")
                ],
              ),
              SizedBox(height: 4),
              TextBody("$_sortByText and $_filterByText"),
              SizedBox(height: 16),
            ],
          );

          return SwipeDelete(
            uniqueId: '${item.id}',
            onTap: () {
              searchController.searchAction(item['keyword']);
            },
            child: _buildItem,
            onDismissed: (action) {
              SavedSearchersController().deleteData(item.id);
            },
          );
        },
      );
    },
  );
}

Widget buildListTile(item) {
  print(item['keyword']);
  return ListTile(
    title: Title3('item.keyword'),
    subtitle: Title3('item.filters'),
  );
}
