import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/helpers/routs.dart';
import 'package:zendy_app/models/recent_search_history_m.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/widgets/typography.dart';

class SearchScreen extends StatelessWidget {
  final SearchHistoryController shCtrl = Get.put(SearchHistoryController());
  final SearchResultController srCtrl = Get.put(SearchResultController());
  final SearchController scCtrl = Get.put(SearchController());

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
          _buildActionBar()
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return Container(
      color: Theme.of(Get.context).primaryColor.withOpacity(0.2),
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
    );
  }

  Widget _buildSearchIcon() {
    return Obx(() {
      if (scCtrl.searchQuery.value == '') {
        return IconButton(
          color: Theme.of(Get.context).primaryColor,
          splashRadius: 28,
          icon: Icon(Icons.search_rounded),
          onPressed: () => {},
        );
      } else {
        return IconButton(
          color: Theme.of(Get.context).primaryColor,
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
        style: Theme.of(Get.context).textTheme.bodyText1,
        autofocus: true,
        textInputAction: TextInputAction.search,
        controller: scCtrl.searchField,
        onFieldSubmitted: (value) => _searchAction(value),
        onChanged: (value) => scCtrl.change(value),
        decoration: InputDecoration(
          fillColor: Theme.of(Get.context).backgroundColor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
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
          suffixIcon: _buildSearchIcon(),
          prefixIcon: _buildBackButton(),
          hintText: 'Search for title, subject, author ...',
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: _buildSearchInput(),
    );
  }
}

Widget _resentSearchHistory() {
  final SearchResultController srCtrl = Get.find();
  final SearchController scCtrl = Get.find();

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
          separatorBuilder: (context, index) => dividerX,
          itemBuilder: (context, index) {
            final item = snapshot.data.docs[index];

            final SearchHistoryModel contactItem =
                SearchHistoryModel.fromQueryDocumentSnapshot(
              queryDocSnapshot: item,
            );

            var _qryVal = contactItem.query;

            return InkWell(
              onTap: () => _searchAction(_qryVal),
              child: Gutter(Flex(
                direction: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Icon(Icons.history_toggle_off),
                  ),
                  Expanded(
                    flex: 7,
                    child: TextBody(_qryVal),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.upgrade_rounded,
                      ),
                      onPressed: () {
                        scCtrl.searchField.text = _qryVal;
                      },
                    ),
                  ),
                ],
              )),
            );
          },
        );
      },
    ),
  );
}

void _searchAction(value) {
  final SearchResultController srCtrl = Get.put(SearchResultController());

  if (value == null) return;
  if (value == '') return;

  srCtrl.searchQry.value = value;
  srCtrl.clearCtrl();
  srCtrl.searchResultsGet();

  Get.offNamed(Goto.searchResult);
}
