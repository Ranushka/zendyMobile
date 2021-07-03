import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';

import 'package:zendy_app/models/saved_search_m.dart';
import 'package:zendy_app/controllers/saved_searchers_c.dart';
// import 'package:zendy_app/helpers/helpers.dart';

class UserSavedScreen extends StatelessWidget {
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

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
      color: Colors.white,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          Title1('Searchers'),
          citationsExportMenu(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTitle(), _buildlist()],
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
        return Center(child: Text('Something went wrong'));
      }

      if (snapshot.data.docs.length < 1) {
        return Center(child: Text('Something went wrong'));
      }

      return ListView.separated(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.size,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = snapshot.data.docs[index];

          final SavedSearchModel contactItem =
              SavedSearchModel.fromQueryDocumentSnapshot(
            queryDocSnapshot: item,
          );

          // print(contactItem);

          return SlidableWidget(
            uniqueId: '${item.id ?? ''}',
            child: ListTile(
              title: Title3(contactItem.keyword),
              subtitle:
                  Title3('In - ${contactItem.sort} - ${contactItem.filters}'),
            ),
            onDismissed: (action) {
              // dismissSlidableItem(context, contactItem, action);
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
