import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:zendy_app/helpers/helpers.dart';

class FromBlogController extends GetxController {
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
      var _response = await dio.get(Api.fromBlog);

      if (_response.statusCode == 200) {
        data.value = _response.data;
      }
    } finally {
      isLoading(false);
    }
  }
}
