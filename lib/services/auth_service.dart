import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:zendy/helpers/helpers.dart';

Map<String, dynamic> createDummyResponse() {
  return {
    "status": true,
    "error": "",
    "user": {
      "id": "cadcf946-fd8e-429a-aeaa-ddde1f555900",
      "role": 1,
      "email": "user2@zendy.io",
      "isEmailVerified": true,
      "firstName": "John",
      "lastName": "Doe",
      "searchCounter": 21,
      "trialExtension": 0,
      "metaData": {
        "metaDataUserRole": "app.metadata.roles.academic_researcher"
      },
      "regionName": "AE",
      "languageCode": "en-gb",
      "intercomIdentified": false
    }
  };
}

class AuthServices {
  static final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://api.staging-oa.zendy.io"));

  static Future signUp(String email, String password) async {
    final url = "/auth/auth";
    final body = json.encode({'email': email, 'password': password});

    try {
      var response = await _dio.post(
        url,
        options: Options(headers: {"Content-Type": "application/json"}),
        data: body,
      );

      var resBody = response.data;

      print(resBody);

      if (response.statusCode == 200) {
        await saveUserTokenData(response);
        showSnackbar(
          type: MsgType.Success,
          message: 'Login success',
        );
        return true;
      } else {
        showSnackbar(
          type: MsgType.Error,
          message: response.toString(),
        );
        return null;
      }
    } catch (e) {
      print('signUp---$e');
      showSnackbar(
        type: MsgType.Error,
        message: 'something went wrong',
      );
      return null;
    }
  }

  static Future signIn(String email, String password) async {
    // final url = "/auth/auth";
    // final body = json.encode({'email': email, 'password': password});

    try {
      if (email == "user1@zendy.io" && password == "Password1") {
        // Simulate saving user data to shared preferences
        final res = createDummyResponse();
        await saveUserTokenData(res);

        showSnackbar(
          type: MsgType.Success,
          message: 'Login success',
        );

        return true;
      } else {
        showSnackbar(
          type: MsgType.Error,
          message: 'Invalid email or password',
        );

        return false;
      }

      // var response = await _dio.post(
      //   url,
      //   options: Options(headers: {"Content-Type": "application/json"}),
      //   data: body,
      // );

      // var resBody = response.data;

      // print('signIn--->$resBody');

      // if (resBody['status'] == false) {
      //   showSnackbar(
      //     type: MsgType.Error,
      //     message: resBody['error'] ?? 'something went wrong',
      //   );

      //   return false;
      // }

      // if (response.statusCode == 200) {
      //   await saveUserTokenData(response);
      //   showSnackbar(
      //     type: MsgType.Success,
      //     message: 'Login success',
      //   );
      //   return true;
      // } else {
      //   showSnackbar(
      //     type: MsgType.Error,
      //     message: response.toString(),
      //   );

      //   return false;
      // }
    } catch (e) {
      print('signIn---$e');
      showSnackbar(
        type: MsgType.Error,
        message: 'something went wrong',
      );
      return false;
    }
  }
}

String getSidValue(response) {
  var value = response.headers['set-cookie'];

  return value;
}

Future saveUserTokenData(response) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  // String authToken = getSidValue(response);
  // String authToken = getSidValue(response);
  // var allData = jsonDecode(response.data);
  // allData['authToken'] = authToken;

  // String userData = jsonEncode(allData);
  String userData = jsonEncode(response);

  await localStorage.setString('user', userData);
  await localStorage.setString('token', response['user']['id']);
}

Future deleteUserTokenData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  await localStorage.clear();
}

Future getTempUserId() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  var tempUserId = localStorage.getString('tempUserId');

  if (tempUserId == null) {
    var tempId = 'temp-${const Uuid().v4()}';
    return tempId;
  }

  return tempUserId;
}

Future getUserData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  var userData = localStorage.getString('user');

  if (userData != null) {
    return jsonDecode(userData);
  }
  return null;
}

final requestClient = Dio();

Future getAuthindicatedResponse(String path, dynamic body) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  final url = "/$path";
  final body0 = json.encode(body);
  var tokenData = localStorage.getString('token').toString();

  print('_tokenData--->$tokenData');

  try {
    var response = await requestClient.post(
      url,
      options: Options(
          headers: {"Content-Type": "application/json", "cookie": tokenData}),
      data: body0,
    );

    return response;
  } catch (e) {
    print('getAuthindicatedResponse---$e');
    return null;
  }
}

Future getResponse(String path, dynamic body) async {
  final body0 = json.encode(body);

  try {
    var response = await requestClient.post(
      path,
      options: Options(headers: {"Content-Type": "application/json"}),
      data: body0,
    );

    return response;
  } catch (e) {
    print('getResponse---$e');
    return null;
  }
}

Future getAokenData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  return localStorage.getString('token');
}
