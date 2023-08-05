import "package:intl/intl.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/widgets/widgets.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key});

  final SearchResultController ctrls = Get.find();

  final SavedSearchersController savedSearchersController = Get.find();

  final ScrollController _scrollController = ScrollController();

  Widget _buildHead(dynamic data) {
    var searchResults = data?.value?.isNotEmpty ?? false ? data!.value![0] : [];

    String keyword =
        searchResults?['searchRequestCriteria']?['searchQuery'][0]['Term'];
    var resultsCount = searchResults?['searchResults']?['totalResults'];
    var resultsCountFormated = NumberFormat.compact().format(
      resultsCount,
    );

    return Container(
      color: Theme.of(Get.context!).colorScheme.background,
      child: Gutter(Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              const SizedBox(height: 16),
              TextSmall('Showing $resultsCountFormated results for'),
              Title2(capitalizeFirst(keyword)),
              const SizedBox(height: 8),
            ],
          ),
          const Spacer(),
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(100),
            child: IconButton(
              icon: Obx(() {
                if (savedSearchersController.isSavedSearch.value) {
                  return Icon(
                    FontIcons.saved_search_added,
                    color: Theme.of(Get.context!).primaryColor,
                  );
                } else {
                  return Icon(
                    FontIcons.saved_search_add,
                    color: Theme.of(Get.context!).hintColor,
                  );
                }
              }),
              onPressed: () {
                SavedSearchersController().saveData(
                  keyword: keyword,
                  count: resultsCount,
                  filters: 'BIO Web of Conferences, Agronomy, English',
                  sort: 'relevence',
                );
              },
            ),
          )
        ],
      )),
    );
  }

  Widget _buildMainContent(dynamic data) {
    var searchResults = data?.value?.isNotEmpty ?? false ? data!.value![0] : [];

    if (searchResults.isEmpty) {
      return const Center(
        child: TextBody('No results found'),
      );
    }

    var itemCount = searchResults?['searchResults']?['results'].length;

    _scrollController.addListener(() {
      var scrolPos = _scrollController.position;
      var loadingStart = scrolPos.maxScrollExtent;

      if (scrolPos.pixels == loadingStart) {
        ctrls.pageNumber.value = ctrls.pageNumber.value + 1;
        ctrls.searchResultsGet();
      }
    });

    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) {
        return Gutter(dividerX);
      },
      itemBuilder: (context, index) {
        final data0 = searchResults?['searchResults']?['results']![index];
        var resultId = data0['resultId'].toString();

        if (resultId == 'null') {
          return const Text('Empty data --');
        }

        if (index == 0) {
          return Column(
            children: <Widget>[
              _buildHead(data),
              SearchResultItem(resultId, data0),
            ],
          );
        }

        if (index == itemCount - 1) {
          return Column(
            children: <Widget>[
              SearchResultItem(resultId, data0),
              _buildSearchResultLoading(paginating: true),
            ],
          );
        }

        return SearchResultItem(resultId, data0);
      },
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 24,
      icon: const Icon(FontIcons.arrow_back),
      onPressed: () => Get.back(),
    );
  }

  Widget _buildSearchBox() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        sortByMenu(),
        const SizedBox(width: 16),
        _buildFilterBtn(),
      ],
    );
  }

  Widget _buildFilterBtn() {
    return OutlinedButton(
      onPressed: () {
        filtersModel();
      },
      child: const Icon(
        FontIcons.filter,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        iconTheme: IconThemeData(color: Theme.of(Get.context!).primaryColor),
        centerTitle: true,
        elevation: 0,
        leading: _buildBackButton(),
        title: _buildSearchBox(),
      ),
    );
  }

  Widget _buildSearchResultLoading({bool paginating = false}) {
    if (paginating) {
      return const Center(
        child: SingleChildScrollView(
          child: Gutter(
            Column(
              children: [
                SizedBox(height: 8),
                Skeleton(height: 160),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }

    return const Center(
      child: SingleChildScrollView(
        child: Gutter(
          Column(
            children: [
              SizedBox(height: 8),
              Skeleton(height: 64),
              SizedBox(height: 32),
              Skeleton(height: 160),
              SizedBox(height: 16),
              Skeleton(height: 160),
              SizedBox(height: 16),
              Skeleton(height: 160),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      appBar: _buildAppBar(),
      body: Obx(() {
        var resultData = ctrls.searchResults.value;

        if (ctrls.isLoading.value) {
          return Center(child: _buildSearchResultLoading());
        }

        if (resultData != null) {
          return _buildMainContent(ctrls.searchResults);
        }

        return const Center(child: TextBody('No results...'));
      }),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
