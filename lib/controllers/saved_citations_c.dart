// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/models/models.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/services/services.dart';

class SavedCitationsController extends GetxController {
  RxInt _contactListCount = 0.obs;
  RxInt get contactListCount => _contactListCount;
  void setContactListCount(int val) => _contactListCount.value = val;

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
      setContactListCount(qSnapItem.size);
    });

    return qSnapStream;
  }

  void saveData(
    String title,
    String sourceUrl,
    String id,
  ) async {
    try {
      var userId = authCtrl.currentUser.value.id;
      SavedCitationsModel _contact = SavedCitationsModel(
        userId: userId,
        id: id,
        title: title,
        sourceUrl: sourceUrl,
      );

      await _service.create(_contact);
      showSnackbar(title: 'Success', message: 'Citation saved');
    } catch (e) {
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void updateContact({
    String title,
    String sourceUrl,
  }) async {
    try {
      var userId = authCtrl.currentUser.value.id;
      SavedCitationsModel _contact = SavedCitationsModel(
        userId: userId,
        title: title,
        sourceUrl: sourceUrl,
      );

      await _service.update(_contact);
    } catch (e) {
      showSnackbar(
        title: 'Error',
        message: e?.message ?? 'something went wrong',
      );
    }
  }

  void deleteContact({SavedCitationsModel contact}) async {
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
