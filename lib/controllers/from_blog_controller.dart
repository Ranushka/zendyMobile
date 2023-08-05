import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

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
      var response = await _request(Api.fromBlog);

      if (response.statusCode == 200) {
        data.value = response.data;
      }
    } finally {
      isLoading(false);
    }
  }
}
