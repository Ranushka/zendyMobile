// import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:zendy_app/models/artical_detail_model.dart';
// import 'package:zendy_app/models/artical_detail_model.dart';

class ArticalServices {
  static var client = http.Client();

  static Uri _getUrl(String articleId) {
    return Uri.https(
      "doaj.org",
      "/api/v2/articles/$articleId",
    );
  }

  static Future<ArticleDetailModel> getDetail(String articleId) async {
    final url = _getUrl(articleId);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return articalDetailFromJson(response.body);
    } else {
      return null;
    }
  }
}
