// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/services/services.dart';
import 'package:zendy_app/models/saved_search_m.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SavedSearchersController extends GetxController {
  final SavedSearcherService _service = SavedSearcherService();
  final AuthController authCtrl = Get.find();

  Stream<QuerySnapshot> getData() {
    var userId = authCtrl.currentUser.value.id;
    Stream<QuerySnapshot> qSnapStream = _service.fetch(userId);

    return qSnapStream;
  }

  void saveData({
    String keyword,
    String sort,
    String filters,
  }) async {
    try {
      var userId = authCtrl.currentUser.value.id;
      SavedSearchModel _contact = SavedSearchModel(
        userId: userId,
        keyword: keyword,
        sort: sort,
        filters: filters,
      );

      await _service.create(_contact);
      showSnackbar(type: MsgType.Success, message: 'Keyword saved');
    } catch (e) {
      showSnackbar(type: MsgType.Error, message: e?.message ?? 'Not saved');
    }
  }

  void updateData({
    String keyword,
    String sort,
    String filters,
  }) async {
    try {
      var userId = authCtrl.currentUser.value.id;
      SavedSearchModel _contact = SavedSearchModel(
        userId: userId,
        keyword: keyword,
        sort: sort,
        filters: filters,
      );

      await _service.update(_contact);
      showSnackbar(type: MsgType.Success, message: 'Keyword updated');
    } catch (e) {
      showSnackbar(type: MsgType.Error, message: e?.message ?? 'Not saved');
    }
  }

  void deleteData(String id) async {
    try {
      await _service.delete(id);
      showSnackbar(
        type: MsgType.Success,
        message: 'Saved search removed',
      );
    } catch (e) {
      showSnackbar(
        type: MsgType.Error,
        message: e?.message ?? 'something went wrong',
      );
    }
  }
}
