import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/models/models.dart';

class SavedCitationsScreen extends StatelessWidget {
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
          text: 'Read list',
          icon: Icons.logout,
          action: citationsExportMenu(),
        ),
        _buildlist()
      ],
      direction: Axis.vertical,
    );
  }
}

Widget _buildlist() {
  return Expanded(
    child: StreamBuilder(
      stream: Get.find<SavedCitationsController>().getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data.toString() == 'null') {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.data.docs.length < 1) {
          return Gutter(Center(
            child: Text(
              'Add to your library will help you to read later',
            ),
          ));
        }

        return ListView.separated(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.size,
          separatorBuilder: (context, index) => dividerX,
          itemBuilder: (context, index) {
            final item = snapshot.data.docs[index];

            final SavedCitationsModel contactItem =
                SavedCitationsModel.fromQueryDocumentSnapshot(
              queryDocSnapshot: item,
            );

            return ListTile(
              tileColor: Theme.of(Get.context).backgroundColor,
              title: TextBody(contactItem.title),
              subtitle: TextSmall("Journal - 2020"),
            );
          },
        );
      },
    ),
  );
}
