import 'package:get/get.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/models/search_model.dart';
import 'package:zendy/services/services.dart';

class SearchResultController extends GetxController {
  var isLoading = true.obs;
  var searchResults = <Map<String, dynamic>>[].obs;
  var filters = List.empty().obs;
  var searchQry = ''.obs;
  var pageNumber = 1.obs;

  void clearCtrl() {
    searchResults.value = [];
    pageNumber.value = 1;
  }

  void clearFiltrs() {
    filters.clear();

    searchResultsGet();
  }

  void toggleFilterItem(facetLabel, categoryId, categoryLabel) {
    var myListFiltered =
        filters.where((item) => item['facetLabel'] == facetLabel);

    if (myListFiltered.isNotEmpty) {
      filters.removeWhere((item) => item['facetLabel'] == facetLabel);
    } else {
      filters.add({
        'active': true,
        'categoryId': categoryId,
        'categoryLabel': categoryLabel,
        'facetLabel': facetLabel,
      });
    }

    searchResultsGet();
  }

  void searchResultsGet() async {
    // final SavedSearchersController savedSearchersController = Get.find();

    try {
      SearchService searchService = SearchService();
      // savedSearchersController.checkIsSaved(searchQry.value);

      if (pageNumber.value == 1) {
        isLoading(true);
      }

      var dataSet = await searchService.getResults(
        filters.value,
        searchQry.value,
        pageNumber.value,
      );

      if (pageNumber > 1) {
        var oldList = searchResults[0]['searchResults']['results'] ?? [];

        print(dataSet);
        var newList = dataSet['searchResults']['results'] ?? [];

        oldList.addAll(newList);

        print(oldList);

        // List<SearchModelResultItem> fullList = oldList;

        dataSet['searchResults']['results'] = oldList;
      }

      if (dataSet != null) {
        searchResults.value = [Map<String, dynamic>.from(dataSet)];
      }
    } finally {
      isLoading(false);
    }
  }
}
