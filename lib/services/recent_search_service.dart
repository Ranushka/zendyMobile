import 'package:zendy_app/models/recent_search_model.dart';
import 'dart:convert';

// final response = .toString();
final response = json.encode([
  {'type': 'a2', 'id': 1, 'title': 'quidem molestiae enim'},
  {'type': 'a1', 'id': 2, 'title': 'sunt qui excepturi placeat culpa'},
  {
    'type': 'a3',
    'id': 99,
    'title': 'consectetur ut id impedit dolores sit ad ex aut'
  },
  {'type': 'a42', 'id': 100, 'title': 'enim repellat iste'}
]);

class RecentSearchService {
  static getItems() {
    var data = recentSearchModelFromJson(response);

    return data;
  }
}
