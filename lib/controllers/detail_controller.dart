import 'package:get/get.dart';

import 'package:zendy_app/models/artical_detail_model.dart';
import 'package:zendy_app/services/artical_services.dart';

class DetailController extends GetxController {
  var isLoading = true.obs;
  var detailData = ArticleDetailModel().obs;

  @override
  void onReady() {
    var articalId = Get.parameters['titleId'];

    if (articalId != null) {
      getArtical(articalId);
    }

    super.onReady();
  }

  void getArtical(String detailId) async {
    print('DetailController getArtical -->' + detailId);
    try {
      isLoading(true);
      var dataSet = await ArticalServices.getDetail(detailId);

      if (dataSet != null) {
        detailData(dataSet);
      }
    } finally {
      isLoading(false);
    }
  }
}
