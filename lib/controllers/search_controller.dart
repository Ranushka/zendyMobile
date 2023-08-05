import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

class CustomSearchController extends GetxController {
  final TextEditingController searchField = TextEditingController();
  final RxString searchQuery = ''.obs;

  void change(value) {
    searchQuery.value = value;
    searchQuery.refresh();
  }

  void clear() {
    searchField.clear();
    searchQuery.value = '';
    searchQuery.refresh();
  }

  void searchAction(value) {
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
}
