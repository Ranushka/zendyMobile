import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          SearchHistory(),
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
              icon: Icon(FontIcons.search_refine),
              onPressed: () {},
              label: TextBody('Advanced search'),
            ),
            TextButton.icon(
              icon: Icon(FontIcons.saved_search),
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
          icon: Icon(FontIcons.search),
          onPressed: () => {},
        );
      } else {
        return IconButton(
          color: Theme.of(Get.context).primaryColor,
          splashRadius: 28,
          icon: Icon(FontIcons.clear),
          onPressed: () => scCtrl.clear(),
        );
      }
    });
  }

  Widget _buildSearchInput() {
    final SearchController searchController = Get.find();

    return Material(
      elevation: 0,
      shadowColor: Theme.of(Get.context).primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        style: Theme.of(Get.context).textTheme.bodyText1,
        autofocus: true,
        textInputAction: TextInputAction.search,
        controller: scCtrl.searchField,
        onFieldSubmitted: (value) => searchController.searchAction(value),
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
          prefixIcon: BackBtn(),
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
