import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthServices {
  static var client = http.Client();

  static Uri getUrl(String urlType) {
    return Uri.https(
      "www.googleapis.com",
      "/v1/accounts:$urlType",
      {"key": "AIzaSyCdEn7TnC_VcI44CRU8AYVceJdhoDyYlWs"},
    );
  }

  static Future signUp(String email, String password) async {
    final url = getUrl('signUp');
    final body = json.encode(
      {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      },
    );

    var response = await client.post(url, body: body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      log(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
