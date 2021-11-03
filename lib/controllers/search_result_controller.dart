import 'package:get/get.dart';
import 'package:zendy_app/models/search_model.dart';
import 'package:zendy_app/services/search_service.dart';
import 'package:zendy_app/controllers/controllers.dart';

class SearchResultController extends GetxController {
  var isLoading = true.obs;
  var searchResults = SearchModel().obs;
  var filters = List.empty().obs;
  var searchQry = ''.obs;
  var pageNumber = 1.obs;

  void clearCtrl() {
    searchResults.value = SearchModel();
    pageNumber.value = 1;
  }

  void clearFiltrs() {
    filters.clear();

    searchResultsGet();
  }

  void toggleFilterItem(catId, name) {
    var myListFiltered = filters.where((item) => item['facetLabel'] == name);

    if (myListFiltered.length > 0) {
      filters.removeWhere((item) => item['facetLabel'] == name);
    } else {
      filters.add({
        'active': true,
        'categoryId': catId,
        'categoryLabel': catId,
        'facetLabel': name,
      });
    }

    searchResultsGet();
  }

  void searchResultsGet() async {
    try {
      if (pageNumber.value == 1) {
        isLoading(true);
      }

      SearchHistoryController().saveContact(searchQry.value);
      print('searchQry >>>>>>>>' + searchQry.value);
      var _dataSet = await SearchService.getResults(
        filters.value,
        searchQry.value,
        pageNumber.value,
      );

      print('_dataSet >>>>>>>');

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
