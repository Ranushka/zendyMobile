import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/models/models.dart';
import 'package:zendy_app/services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final currentUser = UserModel(
    authToken: '',
    email: '',
    firstName: '',
    id: '',
    lastName: '',
    phoneNumber: '',
    theme: 'DEFAULT',
  ).obs;

  @override
  void onInit() {
    super.onInit();

    getTheme().then((data) {
      if (data != null) {
        currentUser.value.theme = data;
      }
    });

    getUserData().then((_userData) {
      if (_userData != null) {
        _setUserData(_userData);
      } else {
        // Assign temp Id to the user
        getTempUserId().then((tempId) => currentUser.value.id = tempId);
      }
    });
  }

  Future setTheme(themeName) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    currentUser.value.theme = themeName;
    await localStorage.setString('theme', themeName);
  }

  Future getTheme() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var themeName = localStorage.getString('theme');

    return themeName;
  }

  bool isLoggedIn() {
    return currentUser.value.authToken != '';
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
