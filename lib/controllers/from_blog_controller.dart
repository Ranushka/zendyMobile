import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

class FromBlogController extends GetxController {
  var isLoading = true.obs;
  var data = [].obs;
  final _request = RequestController().requestGet();

  @override
  void onInit() {
    fetchFeaturedContent();
    super.onInit();
  }

  void fetchFeaturedContent() async {
    try {
      isLoading(true);
      var _response = await _request(Api.fromBlog);

      if (_response.statusCode == 200) {
        data.value = _response.data;
      }
    } finally {
      isLoading(false);
    }
  }
}
