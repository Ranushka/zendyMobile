import 'package:get/get.dart';
import 'package:zendy_app/models/search_model.dart';
import 'package:zendy_app/services/search_service.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SearchResultController extends GetxController {
  var isLoading = true.obs;
  var searchResults = SearchModel().obs;
  var searchQry = ''.obs;
  var pageNumber = 1.obs;

  void clearCtrl() {
    searchResults.value = SearchModel();
    pageNumber.value = 1;
  }

  void searchResultsGet() async {
    try {
      if (pageNumber.value == 1) {
        isLoading(true);
      }
      print('>>>>>>>>' + pageNumber.value.toString() + '--' + searchQry.value);

      SearchHistoryController().saveContact(searchQry.value);
      var _dataSet = await SearchService.getResults(
        searchQry.value,
        pageNumber.value,
      );

      if (pageNumber > 1) {
        List<SearchModelResultItem> _oldList =
            searchResults.value.data.searchResults.results;

        List<SearchModelResultItem> _newList =
            _dataSet.data.searchResults.results;

        _oldList.addAll(_newList);

        List<SearchModelResultItem> _fullList = _oldList;

        _dataSet.data.searchResults.results = _fullList;
      }

      if (_dataSet != null) {
        searchResults(_dataSet);
      }
    } finally {
      isLoading(false);
    }
  }
}
