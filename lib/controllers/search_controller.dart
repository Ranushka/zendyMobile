import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController {
  final TextEditingController searchField = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void change(value) {
    searchQuery.value = value;
    searchQuery.refresh();
  }

  void clear() {
    searchField.clear();
    searchQuery.value = '';
    searchQuery.refresh();
  }
}
