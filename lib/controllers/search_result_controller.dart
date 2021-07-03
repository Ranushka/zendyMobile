import 'package:get/get.dart';
import 'package:zendy_app/models/search_model.dart';
import 'package:zendy_app/services/search_service.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SearchResultController extends GetxController {
  var isLoading = true.obs;
  var searchResults = SearchModel().obs;

  void searchResultsGet(String qry) async {
    try {
      isLoading(true);
      SearchHistoryController().saveContact(qry);
      final dataSet = await SearchService.getResults(qry);

      if (dataSet != null) {
        searchResults(dataSet);
      }
    } finally {
      isLoading(false);
    }
  }
}
