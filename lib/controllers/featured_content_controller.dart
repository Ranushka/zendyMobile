import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:zendy_app/models/models.dart';
import 'package:zendy_app/helpers/helpers.dart';

class FeaturedContentController extends GetxController {
  var isLoading = true.obs;
  var data = [].obs;

  @override
  void onInit() {
    fetchFeaturedContent();
    super.onInit();
  }

  void fetchFeaturedContent() async {
    try {
      isLoading(true);
      var dio = Dio();
      var _response = await dio.get(Api.featuredContent);

      if (_response.statusCode == 200) {
        // var bb = _response.data.toString();
        // var data = FeaturedContentModel.fromJson(bb);
        // print(data);
        data.value = _response.data;
      }
    } finally {
      isLoading(false);
    }
  }
}
