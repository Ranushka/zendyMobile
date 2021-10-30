import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:zendy_app/helpers/helpers.dart';

class BySubjectsController extends GetxController {
  var isLoading = true.obs;
  var data = [].obs;

  @override
  void onInit() {
    fetchContent();
    super.onInit();
  }

  void fetchContent() async {
    try {
      isLoading(true);
      var dio = Dio();
      var _response = await dio.get(Api.bySubjectsUrl);

      if (_response.statusCode == 200) {
        data.value = _response.data;
      }
    } finally {
      isLoading(false);
    }
  }
}
