import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your profile'),
        actions: [_buildUserLogoutBtn()],
      ),
      body: buildSettingsList(),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget buildSettingsList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileTileGroup(
            title: 'Profile',
            content: Column(
              children: [
                ProfileTileInput(
                  title: 'Name',
                  initialValue: 'Johon Pinto',
                  icon: Icons.portrait_rounded,
                  options: languageList,
                  onChange: (val) {
                    print(val);
                  },
                ),
                DividerX,
                ProfileTileInput(
                  title: 'Phone',
                  initialValue: '+971 58 80 5778',
                  icon: Icons.phone_iphone,
                  options: languageList,
                  onChange: (val) {
                    print(val);
                  },
                ),
                DividerX,
                ProfileTileInput(
                  title: 'E-mail',
                  initialValue: 'pinto@zendy.io',
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
                ProfileTileDropdownMultiple(
                  icon: Icons.notifications_active_outlined,
                  title: 'Notifications',
                  initialValue: ['DEFAULT'],
                  options: themesList,
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
    );
  }
}

Widget _buildUserLogoutBtn() {
  return IconButton(
    icon: Icon(Icons.logout),
    onPressed: () => Get.back(),
  );
}
