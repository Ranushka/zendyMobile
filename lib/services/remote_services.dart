import 'package:http/http.dart' as http;
import 'package:zendy_app/models/models.dart';

final requestUrl = Uri.parse(
    'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');

class RemoteServices {
  static var client = http.Client();

  static Future<List<ProductModel>> fetchProducts() async {
    var response = await client.get(requestUrl);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
