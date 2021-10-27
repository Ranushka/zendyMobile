import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/models/models.dart';
import 'package:zendy_app/services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;
  final currentUser = UserModel(
    authToken: '',
    email: '',
    firstName: '',
    id: '',
    lastName: '',
    phoneNumber: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    getUserData().then((_userData) {
      if (_userData != null) {
        _setUserData(_userData);
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
      await AuthServices.signIn(email, password).then((_isLoggedIn) async {
        await getUserData().then((_userData) {
          _setUserData(_userData);
        });

        if (_isLoggedIn) {
          Get.toNamed(Goto.home);
        }
      });
    } finally {
      isLoading(false);
    }
  }

  void logOut() {
    currentUser.value.authToken = '';
    currentUser.value.email = '';
    currentUser.value.firstName = '';
    currentUser.value.id = '';
    currentUser.value.lastName = '';
    currentUser.value.phoneNumber = '';
  }

  void _setUserData(_userData) {
    if (_userData != null) {
      var _data = _userData['user'];
      var _dataAuthToken = _userData['authToken'];

      currentUser.value.authToken = _dataAuthToken;
      currentUser.value.email = _data['email'];
      currentUser.value.firstName = _data['firstName'];
      currentUser.value.id = _data['id'];
      currentUser.value.lastName = _data['lastName'];
      currentUser.value.phoneNumber = _data['phoneNumber'];
    }
  }
}
