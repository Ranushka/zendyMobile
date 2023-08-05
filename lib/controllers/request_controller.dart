import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:zendy/controllers/controllers.dart';

class RequestController extends GetxController {
  final AuthController authCtrl = Get.put(AuthController());

  Dio requestWithAuth() {
    var headers = {"Cookie": authCtrl.currentUser.value.authToken};
    Dio dio = Dio(BaseOptions(headers: headers));
    return dio;
  }

  requestGet() {
    Dio dio = Dio();
    return dio.get;
  }
}
