import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/helpers/helpers.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(),
      backgroundColor: Theme.of(context).backgroundColor,
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
          text: 'Library',
          icon: FontIcons.logout,
          action: citationsExportMenu(),
        ),
        _buildlist()
      ],
      direction: Axis.vertical,
    );
  }
}

_goToWebPage(index) {
  Get.toNamed(
    Goto.libraryReadScreen,
    arguments: index,
  );
}

Widget _buildlist() {
  final LibraryController libraryController = Get.find();

  return Expanded(
    child: StreamBuilder(
      stream: libraryController.getData(),
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
              'Add Search results to your library will help you to read or export later',
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
                SizedBox(height: 12),
                TextBody(item['title']),
                TextSmall(
                    "${item['publicationType']} - ${item['publicationYear']} - ${item['publicationName']}"),
                SizedBox(height: 16),
              ],
            );

            return SwipeDelete(
              uniqueId: '${item.id}',
              onTap: () => _goToWebPage(index),
              child: _buildItem,
              onDismissed: (action) {
                libraryController.deleteData(item.id);
              },
            );
          },
        );
      },
    ),
  );
}
