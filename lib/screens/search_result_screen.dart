import "package:intl/intl.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:zendy_app/helpers/routs.dart';
import 'package:zendy_app/widgets/typography.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/models/search_model.dart';
import 'package:zendy_app/widgets/search_result_item.dart';
import 'package:zendy_app/widgets/widgets.dart';

class SearchResultScreen extends StatelessWidget {
  // final SearchResultController srCrtl = Get.put(SearchResultController());
  final SearchResultController ctrls = Get.find();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      appBar: _buildAppBar(),
      body: Obx(() {
        var _resultData = ctrls.searchResults.value.data;

        if (_resultData != null) {
          return _buildMainContent(ctrls.searchResults.value);
        }

        if (ctrls.isLoading.value) {
          return Center(child: _buildSearchResultLoading());
        }

        return Center(child: TextBody('No results...'));
      }),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildHead(SearchModel data) {
    // final _keyword = data.data
    var _keyword = data.data.searchRequestCriteria.searchQuery[0].term;
    var _totalResults = NumberFormat.compact().format(
      data.data.searchResults.totalResults,
    );

    return Container(
      color: Theme.of(Get.context).backgroundColor,
      child: Gutter(Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              SizedBox(height: 8),
              TextSmall('Showing $_totalResults results for'),
              Title2(_keyword.capitalizeFirst),
              SizedBox(height: 8),
            ],
          ),
          Spacer(),
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(100),
            child: IconButton(
              icon: Icon(Icons.star_border_rounded),
              onPressed: () {
                SavedSearchersController().saveData(
                  keyword: _keyword,
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

  Widget _buildMainContent(SearchModel data) {
    var _searchResults = data.data.searchResults;
    if (_searchResults.results.length == 0) {
      return Center(
        child: TextBody('No results found'),
      );
    }

    var _itemCount = _searchResults.results.length;

    _scrollController.addListener(() {
      var _scrolPos = _scrollController.position;
      var _loadingStart = _scrolPos.maxScrollExtent;

      if (_scrolPos.pixels == _loadingStart) {
        ctrls.pageNumber.value = ctrls.pageNumber.value + 1;
        ctrls.searchResultsGet();
      }
    });

    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: _itemCount,
      separatorBuilder: (context, index) {
        return Gutter(dividerX);
      },
      itemBuilder: (context, index) {
        final _data = _searchResults.results[index];
        if (_data.isBlank) return TextBody('Empty data');

        if (index == 0) {
          return Column(
            children: <Widget>[
              _buildHead(data),
              SearchResultItem(_data.resultId.toString(), _data),
            ],
          );
        }

        if (index == _itemCount - 1) {
          return Column(
            children: <Widget>[
              SearchResultItem(_data.resultId.toString(), _data),
              _buildSearchResultLoading(paginating: true),
            ],
          );
        }

        return SearchResultItem(_data.resultId.toString(), _data);
      },
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 24,
      icon: Icon(CusIcons.arrow_back),
      onPressed: () => Get.back(),
    );
  }

  Widget _buildSearchBox() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        sortByMenu(),
        SizedBox(width: 16),
        _buildFilterBtn(),
      ],
    );
  }

  Widget _buildFilterBtn() {
    return OutlinedButton(
      onPressed: () {
        filtersModel();
      },
      child: Icon(
        CusIcons.filter,
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(Get.context).primaryColor),
      centerTitle: true,
      elevation: 0,
      leading: _buildBackButton(),
      title: _buildSearchBox(),
    );
  }

  Widget _buildSearchResultLoading({bool paginating: false}) {
    if (paginating) {
      return Center(
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

    return Center(
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
}
