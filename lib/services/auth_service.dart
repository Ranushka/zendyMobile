import 'dart:convert';
import 'dart:async';

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

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    var resBody = jsonDecode(response.body);

    print('signIn--->' + resBody.toString());

    if (resBody['status'] == false) {
      showSnackbar(title: 'Fail', message: resBody['error']);
      return false;
    }

    if (response.statusCode == 200) {
      await saveUserTokenData(response);
      showSnackbar(title: 'Login success');
      return true;
    } else {
      showSnackbar(title: 'Fail', message: response.toString());
      return false;
    }
  }
}

String getSidValue(response) {
  var _value = response.headers['set-cookie'];

  return _value;
}

Future saveUserTokenData(response) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  String _authToken = getSidValue(response);
  var _allData = jsonDecode(response.body);
  _allData['authToken'] = _authToken;

  String _userData = jsonEncode(_allData);

  await localStorage.setString('user', _userData);
  await localStorage.setString('token', _authToken);
}

Future deleteUserTokenData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  await localStorage.clear();
}

Future getUserData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  var _userData = localStorage.getString('user');

  print('_tokenData--->' + _userData.toString());
  if (_userData != null) {
    return jsonDecode(_userData);
  }
  return null;
}

final requestClient = http.Client();

Future getAuthindicatedResponse(String path, dynamic body) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  final _url = Uri.https("api.staging-oa.zendy.io", path);
  final _body = json.encode(body);
  var _tokenData = localStorage.getString('token');

  print('_tokenData--->' + _tokenData);

  var _response = await requestClient.post(
    _url,
    headers: {"Content-Type": "application/json", "cookie": _tokenData},
    body: _body,
  );

  if (_response != null) {
    return _response;
  }

  return null;
}

Future getAokenData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  return localStorage.getString('token');
}
