import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/helpers.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  Widget _buildMainContent() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        PageTitle(
          text: 'Library',
          icon: FontIcons.logout,
          action: citationsExportMenu(),
        ),
        _buildlist()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(),
      backgroundColor: Theme.of(context).colorScheme.background,
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
            var providedDataString = snapshot.data[index];
            var _rowId = snapshot.data[index]['id'];
            Map<String, dynamic> _item =
                json.decode(providedDataString['data']);

            var buildItem = Flex(
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.vertical,
              children: [
                const SizedBox(height: 12),
                TextBody(_item['title']),
                TextSmall(
                    "${_item['publicationType']} - ${_item['publicationYear']} - ${_item['publicationName']}"),
                const SizedBox(height: 16),
              ],
            );

            return SwipeDelete(
              uniqueId: _item['permanentLinkId'],
              onTap: () => _goToWebPage(index),
              child: buildItem,
              onDismissed: (action) {
                libraryController.deleteData(_rowId);
              },
            );
          },
        );
      },
    ),
  );
}
