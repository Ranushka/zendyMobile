// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/services/services.dart';

class LibraryController extends GetxController {
  RxInt _savedListCount = 0.obs;

  final SavedCitationsService _service = SavedCitationsService();
  final AuthController authCtrl = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Stream<QuerySnapshot> getData() {
    var userId = authCtrl.currentUser.value.id;
    Stream<QuerySnapshot> qSnapStream = _service.fetchdata(userId);

    qSnapStream.forEach((QuerySnapshot qSnapItem) {
      _savedListCount.value = qSnapItem.size;
    });

    return qSnapStream;
  }

  void saveData(
    String title,
    String readLink,
    String downloadLink,
    String id,
  ) async {
    try {
      var userId = authCtrl.currentUser.value.id;
      var _title = title.replaceAll('<mark>', '').replaceAll('</mark>', '');

      var _data = {
        'userId': userId,
        'id': id,
        'title': _title,
        'readLink': readLink,
        'downloadLink': downloadLink,
      };

      await _service.create(_data);
      showSnackbar(
        type: MsgType.Success,
        message: 'Citation saved',
      );
    } catch (e) {
      showSnackbar(
        type: MsgType.Error,
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void deleteData(id) async {
    try {
      await _service.delete(id);
    } catch (e) {
      showSnackbar(
        type: MsgType.Error,
        message: e?.message ?? 'something went wrong',
      );
    }
  }
}
