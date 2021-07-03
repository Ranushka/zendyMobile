import 'package:http/http.dart' as http;

import 'package:zendy_app/models/search_model.dart';

class SearchService {
  static var client = http.Client();

  static Uri _getUrl(String query) {
    return Uri.https(
      "doaj.org",
      "/api/v2/search/articles/$query",
    );
  }

  static Future<SearchModel> getResults(String searchQuery) async {
    final url = _getUrl(searchQuery);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return searchModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
