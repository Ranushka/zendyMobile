// import 'dart:developer';

import 'package:get/get.dart';
import 'package:zendy/helpers/helpers.dart';
// import 'package:zendy/services/services.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/print_log.dart';
import 'package:zendy/services/local_data_service.dart';

class SearchHistoryController extends GetxController {
  final AuthController authCtrl = Get.find();

  final _service = LocalDataService('search_history');

  Stream getData() {
    Stream<List<dynamic>> dataStream = _service.fetchData('userId');

    return dataStream;
  }

  void createData(String query) async {
    try {
      List<dynamic> existingData = await _service.fetchData('userId').first;

      if (checkIfExists(existingData, 'data', query)) {
        return;
      }
      await _service.create(query);
    } catch (e) {
      printLog('SearchHistoryController--createData', e);
      showSnackbar(
        type: MsgType.Error,
        message: 'Something went wrong.',
      );
    }
  }

  bool checkIfExists(List<dynamic> dataList, String field, dynamic value) {
    for (var item in dataList) {
      if (item[field].replaceAll('"', '') == value) {
        return true;
      }
    }
    return false;
  }

  void deleteData(String data) async {
    try {
      await _service.delete(data);
      // Refresh the list after deletion
      update();
    } catch (e) {
      printLog('SearchHistoryController--deleteData', e);
      showSnackbar(
        type: MsgType.Error,
        message: 'something went wrong',
      );
    }
  }
}
