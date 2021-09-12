import 'package:http/http.dart' as http;

import 'package:zendy_app/models/search_model.dart';
import './auth_service.dart';

class SearchService {
  static var client = http.Client();

  static Uri _getUrl() {
    // https://api.staging-oa.zendy.io/search/oa/search

    return Uri.https(
      "api.staging-oa.zendy.io",
      "/search/oa/search",
    );
  }

  static Future<SearchModel> getResults(String searchQuery) async {
    final _response = await getAuthindicatedResponse('/search/oa/search', {
      "searchQuery": [
        {"term": searchQuery}
      ],
      "filters": [],
      "dateFilters": {"start": "1000-1", "end": "2050-12"},
      "pageNumber": 1
    });

    print('----------->>>>>>>');
    print('----------->>>>>>>');
    print(_response.toString());
    print('----------->>>>>>>');
    print('----------->>>>>>>');

    if (_response.statusCode == 200) {
      return searchModelFromJson(_response.body);
    } else {
      return null;
    }
  }
}
