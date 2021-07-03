import 'package:get/state_manager.dart';
// import 'package:zendy_app/models/product_model.dart';
import 'package:zendy_app/services/auth_service.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void signUp() async {
    try {
      isLoading(true);
      await AuthServices.signUp('sad@gmail.com', '@oass333sda');
    } finally {
      isLoading(false);
    }
  }

  void signIn() async {
    try {
      isLoading(true);
      await AuthServices.signUp('sad@gmail.com', '@oass333sda');
    } finally {
      isLoading(false);
    }
  }
}
