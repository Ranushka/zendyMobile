import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/models/user_model.dart';
import 'package:zendy/services/auth_service.dart';

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

    getUserData().then((userData) {
      if (userData != null) {
        _setUserData(userData);
      } else {
        // Assign temp Id to the user to manage the guest user
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
      await AuthServices.signIn(email, password).then((isLoggedIn) async {
        await getUserData().then((userData) {
          _setUserData(userData);
        });

        if (isLoggedIn) {
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

  void _setUserData(userData) {
    if (userData != null) {
      var data = userData['user'];
      var dataAuthToken = userData['authToken'];

      currentUser.value.authToken = dataAuthToken;
      currentUser.value.email = data['email'];
      currentUser.value.firstName = data['firstName'];
      currentUser.value.id = data['id'];
      currentUser.value.lastName = data['lastName'];
      currentUser.value.phoneNumber = data['phoneNumber'];
    }
  }
}
