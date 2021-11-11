import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/saved_searchers_controllers.dart';

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
          final item = snapshot.data.docs[index];

          var _buildItem = Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              SizedBox(height: 8),
              TextBody(item['keyword']),
              TextSmall("Sort by - ${item['sort']} - ${item['filters']}"),
              SizedBox(height: 8),
            ],
          );

          return SwipeDelete(
            uniqueId: '${item.id}',
            onTap: () => {},
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
