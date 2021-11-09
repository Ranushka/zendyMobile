// import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/services/services.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SearchHistoryController extends GetxController {
  final SearchHistoryService _service = SearchHistoryService();
  final AuthController authCtrl = Get.find();

  Stream<QuerySnapshot> getData() {
    var userId = authCtrl.currentUser.value.id;
    Stream<QuerySnapshot> qSnapStream = _service.fetchdata(userId);

    return qSnapStream;
  }

  void createData(String query) async {
    try {
      var userId = authCtrl.currentUser.value.id;
      var _data = {
        userId: userId,
        query: query,
      };

      await _service.create(_data);
    } catch (e) {
      print('======');
      print(e);
      print('======');
      showSnackbar(
        type: MsgType.Error,
        message: e['message'] ?? 'something went wrong',
      );
    }
  }

  void deleteData({data}) async {
    try {
      await _service.delete(data);
    } catch (e) {
      showSnackbar(
        type: MsgType.Error,
        message: e?.message ?? 'something went wrong',
      );
    }
  }
}
