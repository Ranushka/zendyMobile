import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:zendy_app/controllers/controllers.dart';

class RequestController extends GetxController {
  final AuthController authCtrl = Get.put(AuthController());

  // var _headers = {"Cookie": authCtrl.currentUser.value.authToken};
  // Dio dio = Dio(BaseOptions(headers: this._headers));

  request() {
    var _headers = {"Cookie": authCtrl.currentUser.value.authToken};
    Dio dio = Dio(BaseOptions(headers: _headers));
    return dio;
  }
}
