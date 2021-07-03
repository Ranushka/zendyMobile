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
      children: [_buildTitle(), _buildlist()],
      direction: Axis.vertical,
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
          Title1('Citations'),
          citationsExportMenu(),
        ],
      ),
    );
  }

  // Widget _buildlist() {
  //   return Expanded(
  //     child: ListView(
  //       children: [
  //         for (int count in List.generate(9, (index) => index + 1))
  //           ListTile(
  //             title: Title3(
  //                 "Joy, Exercise, Enjoyment, Getting out: A Qualitative Study of Older People's Experience of Cycling in Sydney, Australia"),
  //             subtitle: Text("Journal - 2020"),
  //             trailing: Icon(Icons.check_box_outline_blank_rounded),
  //             leading: Text("0$count."),
  //             minLeadingWidth: 0,
  //           ),
  //       ],
  //     ),
  //   );
  // }
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
          return Center(child: Text('Something went wrong'));
        }

        return ListView.separated(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.size,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = snapshot.data.docs[index];

            final SavedCitationsModel contactItem =
                SavedCitationsModel.fromQueryDocumentSnapshot(
              queryDocSnapshot: item,
            );

            return ListTile(
              title: Text(contactItem.title),
              subtitle: Text("Journal - 2020"),
            );
          },
        );
      },
    ),
  );
}
