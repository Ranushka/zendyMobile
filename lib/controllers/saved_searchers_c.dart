// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/services/services.dart';
import 'package:zendy_app/models/saved_search_m.dart';
import 'package:zendy_app/helpers/helpers.dart';

class SavedSearchersController extends GetxController {
  final SavedSearcherService _service = SavedSearcherService();

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot> qSnapStream = _service.fetch('073571245X');

    return qSnapStream;
  }

  void saveData({
    String keyword,
    String sort,
    String filters,
  }) async {
    try {
      SavedSearchModel _contact = SavedSearchModel(
        userId: '073571245X',
        keyword: keyword,
        sort: sort,
        filters: filters,
      );

      await _service.create(_contact);
      showSnackbar(title: 'Success', message: 'Contact saved');
    } catch (e) {
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void updateData({
    String keyword,
    String sort,
    String filters,
  }) async {
    try {
      SavedSearchModel _contact = SavedSearchModel(
        userId: '073571245X',
        keyword: keyword,
        sort: sort,
        filters: filters,
      );

      await _service.update(_contact);
    } catch (e) {
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void deleteData({SavedSearchModel contact}) async {
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
