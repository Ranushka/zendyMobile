import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/models/saved_search_m.dart';
import 'package:zendy_app/helpers/routs.dart';
import 'package:zendy_app/models/recent_search_history_m.dart';
import 'package:zendy_app/widgets/widgets.dart';

import 'package:zendy_app/controllers/controllers.dart';

class SearchScreen extends StatelessWidget {
  final SearchResultController srCtrl = Get.find();
  final SearchController scCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      appBar: _buildAppBar() as PreferredSizeWidget,
      body: Flex(
        direction: Axis.vertical,
        children: [
          // Title4('RECENT SEARCHES'),
          _resentSearchHistory(),
          Container(
            color: Theme.of(Get.context).primaryColorLight,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.filter_center_focus),
                    onPressed: () {},
                    label: Text('Advanced search'),
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.saved_search),
                    onPressed: () {
                      Get.toNamed(Goto.searches);
                    },
                    label: Text('Saved searchers'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Obx(() {
      if (scCtrl.searchQuery.value == '') {
        return IconButton(
          splashRadius: 28,
          icon: Icon(Icons.search_rounded),
          onPressed: () => {},
        );
      } else {
        return IconButton(
          splashRadius: 28,
          icon: Icon(Icons.close_rounded),
          onPressed: () => scCtrl.clear(),
        );
      }
    });
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 28,
      color: Colors.black26,
      icon: Icon(Icons.arrow_back_rounded),
      onPressed: () {
        Get.back();
      },
    );
  }

  Widget _buildSearchInput() {
    return Material(
      elevation: 0,
      shadowColor: Theme.of(Get.context).primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        autofocus: true,
        textInputAction: TextInputAction.search,
        controller: scCtrl.searchField,
        onFieldSubmitted: (value) {
          if (value == null) return;
          if (value == '') return;

          srCtrl.searchResultsGet(value);
          Get.offNamed(Goto.searchResult);
        },
        onChanged: (value) => scCtrl.change(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(Get.context).primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(Get.context).primaryColor,
              width: 1.5,
            ),
          ),
          prefixIcon: _buildBackButton(),
          suffixIcon: _buildSearchIcon(),
          hintText: 'Search for title ...',
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: _buildSearchInput(),
    );
  }
}

Widget _resentSearchHistory() {
  final SearchResultController srCtrl = Get.find();

  return Expanded(
    child: StreamBuilder(
      stream: Get.find<SearchHistoryController>().getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data.toString() == 'null') {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.data.docs.length < 1) {
          return Center(child: Text('Start searching...'));
        }

        return ListView.separated(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.size,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = snapshot.data.docs[index];

            final SearchHistoryModel contactItem =
                SearchHistoryModel.fromQueryDocumentSnapshot(
              queryDocSnapshot: item,
            );

            return ListTile(
              minLeadingWidth: 32,
              leading: Icon(Icons.history_toggle_off),
              title: Text(contactItem.query),
              onTap: () {
                srCtrl.searchResultsGet(contactItem.query);
                Get.offNamed(Goto.searchResult);
              },
              trailing: IconButton(
                icon: Icon(Icons.upgrade_rounded),
                onPressed: () => {},
              ),
            );
          },
        );
      },
    ),
  );
}
