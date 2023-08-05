import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  final SearchHistoryController shCtrl = Get.put(SearchHistoryController());
  final SearchResultController srCtrl = Get.put(SearchResultController());
  final CustomSearchController scCtrl = Get.put(CustomSearchController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      appBar: _buildAppBar(),
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
      color: Theme.of(Get.context!).primaryColor.withOpacity(0.2),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(FontIcons.search_refine),
              onPressed: () {},
              label: const TextBody('Advanced search'),
            ),
            TextButton.icon(
              icon: const Icon(FontIcons.saved_search),
              onPressed: () {
                Get.toNamed(Goto.searches);
              },
              label: const TextBody('Saved searchers'),
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
          color: Theme.of(Get.context!).primaryColor,
          splashRadius: 28,
          icon: const Icon(FontIcons.search),
          onPressed: () => {},
        );
      } else {
        return IconButton(
          color: Theme.of(Get.context!).primaryColor,
          splashRadius: 28,
          icon: const Icon(FontIcons.clear),
          onPressed: () => scCtrl.clear(),
        );
      }
    });
  }

  Widget _buildSearchInput() {
    final CustomSearchController searchController = Get.find();

    return Material(
      elevation: 0,
      shadowColor: Theme.of(Get.context!).primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        autofocus: true,
        textInputAction: TextInputAction.search,
        controller: scCtrl.searchField,
        onFieldSubmitted: (value) => searchController.searchAction(value),
        onChanged: (value) => scCtrl.change(value),
        decoration: InputDecoration(
          fillColor: Theme.of(Get.context!).colorScheme.background,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(Get.context!).primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(Get.context!).primaryColor,
              width: 1.5,
            ),
          ),
          suffixIcon: _buildSearchIcon(),
          prefixIcon: const BackBtn(),
          hintText: 'Search for title, subject, author ...',
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: _buildSearchInput(),
    );
  }
}
