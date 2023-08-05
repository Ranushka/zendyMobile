// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/services/services.dart';

class LibraryController extends GetxController {
  final RxInt _savedListCount = 0.obs;

  final SavedCitationsService _service = SavedCitationsService();
  final AuthController authCtrl = Get.find();

  Stream getData() {
    var userId = authCtrl.currentUser.value.id.toString();

    Stream<List<dynamic>> dataStream = _service.fetchdata(userId);

    return dataStream;
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
      print('deleteData---');
      print(e);
      print('deleteData---');

      showSnackbar(
        type: MsgType.Error,
        message: 'something went wrong',
      );
    }
  }
}
