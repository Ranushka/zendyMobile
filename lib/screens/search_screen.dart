import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/widgets/widgets.dart';

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
          _resentSearchHistory(),
          _buildActionBar(),
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
              icon: Icon(CusIcons.search_refine),
              onPressed: () {},
              label: TextBody('Advanced search'),
            ),
            TextButton.icon(
              icon: Icon(CusIcons.saved_search),
              onPressed: () {
                Get.toNamed(Goto.searches);
              },
              label: TextBody('Saved searchers'),
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
          icon: Icon(CusIcons.search),
          onPressed: () => {},
        );
      } else {
        return IconButton(
          color: Theme.of(Get.context).primaryColor,
          splashRadius: 28,
          icon: Icon(CusIcons.clear),
          onPressed: () => scCtrl.clear(),
        );
      }
    });
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 28,
      color: Colors.black26,
      icon: Icon(
        CusIcons.arrow_back,
        color: Theme.of(Get.context).primaryColor,
      ),
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
  final SearchController searchController = Get.find();
  final SearchHistoryController searchHistoryController = Get.find();

  return Expanded(
    child: StreamBuilder(
      stream: searchHistoryController.getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data.toString() == 'null') {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: TextBody('Something went wrong'));
        }

        if (snapshot.data.docs.length < 1) {
          return Center(child: TextBody('Start searching...'));
        }

        return ListView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.size,
          itemBuilder: (context, index) {
            final _data = snapshot.data.docs[index];

            var _qryText = _data['query'];

            return Dismissible(
              key: Key(_data.id),
              background: Container(color: Colors.red),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                searchHistoryController.deleteData(_data.id);
              },
              child: InkWell(
                onTap: () => _searchAction(_qryText),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Gutter(Flex(
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Icon(CusIcons.history),
                        ),
                        Expanded(
                          flex: 7,
                          child: TextBody(_qryText),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: IconButton(
                            icon: Icon(
                              CusIcons.history_reuse,
                            ),
                            onPressed: () {
                              searchController.searchField.text = _qryText;
                            },
                          ),
                        ),
                      ],
                    )),
                    dividerX
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

void _searchAction(value) {
  final SearchResultController srCtrl = Get.find();
  final SearchHistoryController shCtrl = Get.find();

  if (value == null) return;
  if (value == '') return;

  srCtrl.searchQry.value = value;
  srCtrl.clearCtrl();
  srCtrl.searchResultsGet();
  shCtrl.createData(value);

  Get.offNamed(Goto.searchResult);
}
