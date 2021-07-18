import 'dart:convert';
import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zendy_app/helpers/helpers.dart';

class AuthServices {
  static var client = http.Client();

  static Future signUp(String email, String password) async {
    final url = Uri.https("api.staging-oa.zendy.io", "/auth/auth");

    final body = json.encode(
      {'email': email, 'password': password},
    );

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    var resBody = json.decode(response.body);

    print(resBody);

    if (response.statusCode == 200) {
      await saveUserTokenData(response);
      showSnackbar(title: 'Login success');
      return true;
    } else {
      showSnackbar(title: 'Fail', message: response.toString());
      return null;
    }
  }

  static Future signIn(String email, String password) async {
    final url = Uri.https("api.staging-oa.zendy.io", "/auth/auth");
    final body = json.encode({'email': email, 'password': password});

    print(url);
    print(body);
    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    var resBody = json.decode(response.body);

    print(resBody);

    if (response.statusCode == 200) {
      await saveUserTokenData(response);
      showSnackbar(title: 'Login success');
      return true;
    } else {
      showSnackbar(title: 'Fail', message: response.toString());
      return null;
    }
  }
}

String getSidValue(response) {
  var _value = response.headers['set-cookie'];
  // _value = _value.split(';');
  // _value = _value[0];
  // _value = _value.replaceAll('connect.sid=', '');

  return _value;
}

Future saveUserTokenData(response) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  String _userToken = getSidValue(response);
  String _userData = response.body;

  await localStorage.setString('user', _userData);
  await localStorage.setString('token', _userToken);
}

Future getUserData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  var _userData = localStorage.getString('user');

  print(_userData);
  if (_userData != null) {
    return jsonDecode(_userData);
  }
  return null;
}
