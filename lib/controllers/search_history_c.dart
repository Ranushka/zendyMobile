// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/models/recent_search_history_m.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/services/search_history_s.dart';

class SearchHistoryController extends GetxController {
  final SearchHistoryService _service = SearchHistoryService();

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot> qSnapStream = _service.fetchdata('073571245X');

    return qSnapStream;
  }

  void saveContact(String query) async {
    try {
      SearchHistoryModel _contact = SearchHistoryModel(
        userId: '073571245X',
        query: query,
      );

      await _service.create(_contact);
    } catch (e) {
      print(e);
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void updateContact({
    String userId,
    String query,
  }) async {
    try {
      SearchHistoryModel _contact = SearchHistoryModel(
        userId: userId,
        query: query,
      );

      await _service.update(_contact);
    } catch (e) {
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void deleteContact({SearchHistoryModel contact}) async {
    try {
      await _service.delete(contact);
    } catch (e) {
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }
}
