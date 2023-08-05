import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
// import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
// import 'package:flutter_app_restart/flutter_app_restart.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/services/services.dart';

class SettingsScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      appBar: emptyAppbar(),
      body: _buildMainContent(context),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildMainContent(context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        PageTitle(
          text: 'Profile',
          icon: Icons.logout,
          action: _buildUserLogoutBtn(context),
        ),
        buildSettingsList()
      ],
    );
  }

  Widget buildSettingsList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfo(),
            ProfileTileGroup(
              title: 'Application',
              content: Column(
                children: [
                  // SmartSelect<String>.single(
                  //     title: 'Frameworks',
                  //     value: value,
                  //     choiceItems: options,
                  //     onChange: (state) => setState(() => value = state.value)),

                  // ProfileTileDropdown(
                  //   title: 'Language',
                  //   // initialValue: languageList[0].title,
                  //   options: languageList,
                  //   onChange: (val) {
                  //     print(val);
                  //   },
                  // ),
                  FrameworkSelect(
                    title: 'Language',
                    icon: Icons.language_rounded,
                    options: languageList,
                    selectedValue: '${languageList[0].title}',
                  ),
                  dividerX,
                  FrameworkSelect(
                    title: 'Font size',
                    icon: Icons.font_download_outlined,
                    options: fontSizeList,
                    selectedValue: '${fontSizeList[0].title}',
                  ),
                  dividerX,
                  FrameworkSelect(
                    title: 'Theme',
                    icon: Icons.image_search_outlined,
                    options: themesList,
                    selectedValue: '${themesList[0].title}',
                    onChange: (val) {
                      authController.setTheme(val).then((value) => {
                            Restart.restartApp(webOrigin: '/'),
                          });
                    },
                  ),
                  dividerX,
                  ProfileTileRadio(
                    icon: Icons.notifications_active_outlined,
                    title: 'Notifications',
                    initialValue: true,
                    onChange: (val) {
                      print(val);
                    },
                  ),
                ],
              ),
            ),
            ProfileTileGroup(
              title: 'Miscellaneous',
              content: Column(
                children: [
                  ProfileTile(
                    title: 'Product tour',
                    action: () => {},
                  ),
                  dividerX,
                  ProfileTile(
                    title: 'FAQ',
                    action: () => {},
                  ),
                  dividerX,
                  ProfileTile(
                    title: 'Feedback',
                    subTitle: 'Report any issues or request featchrs.',
                    action: () => {},
                  ),
                  dividerX,
                  ProfileTile(
                    title: 'Terms of Service',
                    action: () => {},
                  ),
                ],
              ),
            ),
            const Column(
              children: [
                SizedBox(height: 32),
                Opacity(opacity: 0.5, child: TextSmall('Version: 1.4.0')),
                SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildUserInfo() {
  final AuthController authController = Get.find();

  // var rawNumber = authController.currentUser.value.phoneNumber;
  var firstName = authController.currentUser.value.firstName;
  var lastName = authController.currentUser.value.lastName;
  var email = authController.currentUser.value.email;
  // var _phoneNumber = FlutterLibphonenumber().formatNumberSync(rawNumber);
  var fullName = '$firstName $lastName';

  return Obx(() {
    if (!authController.isLoggedIn()) {
      return Column(children: [
        SizedBox(height: 16),
        JoinZendy(),
      ]);
    }

    return Column(children: [
      ProfileTileGroup(
        title: 'Profile',
        content: Column(
          children: [
            ProfileTileInput(
              title: 'Name',
              initialValue: fullName,
              icon: Icons.portrait_rounded,
              options: languageList,
            ),
            // dividerX,
            // ProfileTileInput(
            //   title: 'Phone',
            //   initialValue: _phoneNumber,
            //   icon: Icons.phone_iphone,
            //   options: languageList,
            //   onChange: (val) {
            //     print(val);
            //   },
            // ),
            dividerX,
            ProfileTileInput(
              title: 'E-mail',
              initialValue: email,
              icon: Icons.email_outlined,
              options: languageList,
            ),
            dividerX,
            ProfileTileInterests(),
            dividerX,
            const ProfileTileProfession()
          ],
        ),
      ),
      ProfileTileGroup(
        title: 'Subscription',
        content: buildUserSubscrionInfo(),
      ),
    ]);
  });
}

Widget _buildUserLogoutBtn(context) {
  final AuthController authController = Get.find();

  if (!authController.isLoggedIn()) {
    return Container();
  }

  return IconButton(
    icon: const Icon(Icons.logout),
    onPressed: () {
      deleteUserTokenData();
      authController.logOut();
      Get.toNamed('/');
    },
  );
}
