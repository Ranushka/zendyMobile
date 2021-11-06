import 'package:http/http.dart' as http;

import 'package:zendy_app/models/search_model.dart';
import './auth_service.dart';

class SearchService {
  static var client = http.Client();

  static Future<SearchModel> getResults(
    List facetFilters,
    String searchQuery,
    int pageNumber,
  ) async {
    pageNumber ??= 1;
    facetFilters ??= List.empty();

    final _response = await getResponse('/search/oa/search', {
      "searchQuery": [
        {"term": searchQuery}
      ],
      "facetFilters": facetFilters,
      "dateFilters": {"start": "1000-1", "end": "2050-12"},
      "pageNumber": pageNumber
    });

    if (_response.statusCode == 200) {
      return searchModelFromJson(_response.body);
    } else {
      return null;
    }
  }
}
