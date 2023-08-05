import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

class BySubjectsController extends GetxController {
  var isLoading = true.obs;
  var data = [].obs;
  final _request = RequestController().requestGet();

  @override
  void onInit() {
    fetchContent();
    super.onInit();
  }

  void fetchContent() async {
    try {
      isLoading(true);
      var response = await _request(Api.bySubjectsUrl);

      if (response.statusCode == 200) {
        data.value = response.data;
      }
    } finally {
      isLoading(false);
    }
  }
}
