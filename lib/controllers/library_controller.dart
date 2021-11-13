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

  void saveData(dynamic data) async {
    try {
      data['title'] =
          data['title'].replaceAll('<mark>', '').replaceAll('</mark>', '');

      await _service.create(data);
      showSnackbar(
        type: MsgType.Success,
        message: 'Citation saved',
      );
    } catch (e) {
      showSnackbar(
        type: MsgType.Error,
        message: 'something went wrong',
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
