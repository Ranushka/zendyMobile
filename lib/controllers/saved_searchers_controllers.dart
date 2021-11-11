// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/services/services.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SavedSearchersController extends GetxController {
  final SavedSearcherService _service = SavedSearcherService();
  final AuthController authCtrl = Get.find();
  final SearchResultController searchResultController = Get.find();
  var isSavedSearch = false.obs;

  void onInit() {
    super.onInit();
  }

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot> qSnapStream = _service.fetch();

    return qSnapStream;
  }

  Future checkIsSaved(keyword) async {
    var data = await _service.findOne(keyword);
    isSavedSearch.value = data.size >= 1;
  }

  void saveData({
    String keyword,
    num count,
    String sort,
    String filters,
  }) async {
    try {
      var _data = {
        'keyword': keyword,
        'sort': sort,
        'count': count,
        'filters': filters,
      };

      await _service.create(_data);
      showSnackbar(type: MsgType.Success, message: 'Keyword saved');
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
