// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/models/models.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/services/services.dart';

class SavedCitationsController extends GetxController {
  RxInt _contactListCount = 0.obs;
  RxInt get contactListCount => _contactListCount;
  void setContactListCount(int val) => _contactListCount.value = val;

  final SavedCitationsService _service = SavedCitationsService();

  @override
  void onInit() {
    super.onInit();
  }

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot> qSnapStream = _service.fetchdata('073571245X');

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
      SavedCitationsModel _contact = SavedCitationsModel(
        userId: '073571245X',
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
      SavedCitationsModel _contact = SavedCitationsModel(
        userId: '073571245X',
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
