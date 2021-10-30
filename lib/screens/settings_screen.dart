import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/services/services.dart';

class SettingsScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: emptyAppbar(),
      body: _buildMainContent(context),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildMainContent(context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          text: 'Profile',
          icon: Icons.logout,
          action: _buildUserLogoutBtn(context),
        ),
        buildSettingsList()
      ],
      direction: Axis.vertical,
    );
  }

  Widget buildSettingsList() {
    FlutterLibphonenumber().init();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfo(),
            ProfileTileGroup(
              title: 'Application',
              content: Column(
                children: [
                  ProfileTileDropdown(
                    title: 'Language',
                    initialValue: 'en',
                    options: languageList,
                    onChange: (val) {
                      print(val);
                    },
                  ),
                  DividerX,
                  ProfileTileDropdown(
                    icon: Icons.font_download_outlined,
                    title: 'Font size',
                    initialValue: 'md',
                    options: fontSizeList,
                    onChange: (val) {
                      print(val);
                    },
                  ),
                  DividerX,
                  ProfileTileDropdown(
                    icon: Icons.image_search_outlined,
                    title: 'Theme',
                    initialValue: 'DEFAULT',
                    options: themesList,
                    onChange: (val) {
                      print(val);
                    },
                  ),
                  DividerX,
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
              title: 'Misc',
              content: Column(
                children: [
                  ProfileTile(
                    title: 'Product tour',
                    action: () => {},
                  ),
                  DividerX,
                  ProfileTile(
                    title: 'FAQ',
                    action: () => {},
                  ),
                  DividerX,
                  ProfileTile(
                    title: 'Feedback',
                    subTitle: 'Report any issues or request featchrs.',
                    action: () => {},
                  ),
                  DividerX,
                  ProfileTile(
                    title: 'Terms of Service',
                    action: () => {},
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 32),
                Text(
                  'Version: 1.4.0',
                  style: TextStyle(color: Color(0xFF777777)),
                ),
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

  var rawNumber = authController.currentUser.value.phoneNumber;
  var _firstName = authController.currentUser.value.firstName;
  var _lastName = authController.currentUser.value.lastName;
  var _email = authController.currentUser.value.email;
  var _phoneNumber = FlutterLibphonenumber().formatNumberSync(rawNumber);
  var _fullName = '$_firstName $_lastName';

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
              initialValue: _fullName,
              icon: Icons.portrait_rounded,
              options: languageList,
              onChange: (val) {
                print(val);
              },
            ),
            DividerX,
            ProfileTileInput(
              title: 'Phone',
              initialValue: _phoneNumber,
              icon: Icons.phone_iphone,
              options: languageList,
              onChange: (val) {
                print(val);
              },
            ),
            DividerX,
            ProfileTileInput(
              title: 'E-mail',
              initialValue: _email,
              icon: Icons.email_outlined,
              options: languageList,
              onChange: (val) {
                print(val);
              },
            ),
            DividerX,
            ProfileTileInterests(),
            DividerX,
            ProfileTileProfession()
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
    icon: Icon(Icons.logout),
    onPressed: () {
      print('user loging out');
      deleteUserTokenData();
      authController.logOut();
      // Get.reset();
      // Get.put(SavedCitationsController());
      // Get.put(SearchHistoryController());
      // Get.put(SearchResultController());
      // Get.put(SearchController());
      Get.toNamed('/');
    },
  );
}
