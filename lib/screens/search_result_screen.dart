// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:zendy_app/helpers/routs.dart';
import 'package:zendy_app/widgets/typography.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/models/search_model.dart';
import 'package:zendy_app/widgets/search_result_item.dart';
import 'package:zendy_app/widgets/widgets.dart';

class SearchResultScreen extends StatelessWidget {
  final SearchResultController srCrtl = Get.put(SearchResultController());
  final SearchResultController ctrls = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (srCrtl.isLoading.value)
          return Center(child: CircularProgressIndicator());
        else {
          return _buildMainContent(srCrtl.searchResults.value);
        }
      }),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildHead(SearchModel data) {
    final _keyword = data.query.capitalizeFirst;
    return Container(
      color: Colors.white,
      child: Gutter(Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              SmallMute('Showing 203k results for'),
              Title2(_keyword),
              SizedBox(height: 16),
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
    if (data.results.length == 0) {
      return Center(
        child: Text('No results found'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.results.length,
      separatorBuilder: (context, index) {
        return Gutter(Divider(
          color: Colors.black26,
          height: 0,
        ));
      },
      itemBuilder: (context, index) {
        final _id = data.results[index].id;
        final _data = data.results[index].bibjson;
        if (_id.isEmpty & _data.isBlank) return Text('Empty data');

        if (index == 0) {
          return Column(
            children: <Widget>[
              _buildHead(data),
              SearchResultItem(_id, _data),
            ],
          );
        }

        return SearchResultItem(_id, _data);
      },
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      splashRadius: 24,
      icon: Icon(Icons.arrow_back_rounded),
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
      centerTitle: true,
      elevation: 0,
      leading: _buildBackButton(),
      title: _buildSearchBox(),
    );
  }
}
