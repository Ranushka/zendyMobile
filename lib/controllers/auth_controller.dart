import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/models/models.dart';
import 'package:zendy_app/services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;
  final currentUser = UserModel(name: '', last: '', email: '').obs;

  @override
  void onInit() {
    super.onInit();
    getUserData().then((_userData) {
      if (_userData != null) {
        var _data = _userData['user'];

        currentUser.value.name = _data['firstName'];
        currentUser.value.last = _data['lastName'];
        currentUser.value.email = _data['email'];

        // userData.addAll(_userData);
        print(_userData);
      }
    });
  }

  void signUp() async {
    try {
      isLoading(true);
      await AuthServices.signUp('sad@gmail.com', '@oass333sda');
    } finally {
      isLoading(false);
    }
  }

  void signIn(email, password) async {
    try {
      isLoading(true);
      await AuthServices.signIn(email, password).then((_isLoggedIn) {
        if (_isLoggedIn) {
          Get.toNamed(Goto.home);
        }
      });
    } finally {
      isLoading(false);
    }
  }
}
