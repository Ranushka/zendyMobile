import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

class FeaturedContentController extends GetxController {
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

      var response = await _request(Api.featuredContent);

      if (response.statusCode == 200) {
        data.value = response.data;
      }
    } catch (e) {
      print('error ---');
      print(e);
      print('error ---');
    } finally {
      isLoading(false);
    }
  }
}
