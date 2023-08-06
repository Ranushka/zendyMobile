// import 'dart:developer';

import 'package:get/get.dart';
import 'package:zendy/services/local_data_service.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

class SavedSearchersController extends GetxController {
  final _service = new LocalDataService('saved_searchers');

  final AuthController authCtrl = Get.find();
  var isSavedSearch = false.obs;

  Stream getData() {
    Stream<List<dynamic>> dataStream = _service.fetchData('userId');

    return dataStream;
  }

  Future checkIsSaved(keyword) async {
    // var data = await savedSearchersService.findOne(keyword);
    // isSavedSearch.value = data.size >= 1;
  }

  void saveData({
    String? keyword,
    num? count,
    String? sort,
    String? filters,
  }) async {
    try {
      var data = {
        'keyword': keyword,
        'sort': sort,
        'count': count,
        'filters': filters,
      };

      await _service.create(data);
      showSnackbar(type: MsgType.Success, message: 'Keyword saved');
    } catch (e) {
      print('SavedSearchersControllersaveData---');
      print(e);
      print('SavedSearchersControllersaveData---');
      showSnackbar(type: MsgType.Error, message: 'Not saved');
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
      print('SavedSearchersControllerdeleteData---');
      print(e);
      print('SavedSearchersControllerdeleteData---');
      showSnackbar(
        type: MsgType.Error,
        message: 'something went wrong',
      );
    }
  }
}
