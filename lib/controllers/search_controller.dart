// import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zendy_app/models/recent_search_model.dart';
// import 'package:zendy_app/models/saved_search_model.dart';
// import 'package:zendy_app/models/search_model.dart';
// import 'package:zendy_app/services/saved_search_service.dart';
// import 'package:zendy_app/services/search_service.dart';

class SearchController extends GetxController {
  final TextEditingController searchField = TextEditingController();
  final RxString searchQuery = ''.obs;
  // final resentSearchers = <RecentSearchModel>[].obs;
  // final savedSearchers = <SavedSearchModel>[].obs;

  @override
  void onInit() {
    // resentSearchersGet();

    super.onInit();
  }

  void change(value) {
    searchQuery.value = value;
    searchQuery.refresh();
    // update();
  }

  void clear() {
    searchField.clear();
    searchQuery.value = '';
    searchQuery.refresh();
  }
}
