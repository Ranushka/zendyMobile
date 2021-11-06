import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy_app/widgets/from_blog.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Scaffold(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      appBar: emptyAppbar(),
      body: Container(
        child: SingleChildScrollView(
          child: _buildMainContent(),
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildMainContent() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckConnection(),
        _buildHeroCall(),
        _buildDumySearchInput(),
        SizedBox(height: 8),
        LatestNewsList(),
        BySubjects(),
        SizedBox(height: 32),
        JoinZendy(),
        FromBlog(),
        SizedBox(height: 32),
      ],
      direction: Axis.vertical,
    );
  }

  Widget _buildHeroCall() {
    return Container(
      color: Theme.of(Get.context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          _buildUserGreating(),
          SizedBox(height: 16),
          Gutter(Title1('Research is creating new knowledge.')),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildUserGreating() {
    return Obx(() {
      if (authController.currentUser.value.firstName != '')
        return Gutter(Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getLogoImg(80),
            TextBody('G, day ${authController.currentUser.value.firstName}'),
          ],
        ));
      else
        return Gutter(Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getLogoImg(80),
            TextButton(
              onPressed: () => Get.toNamed(Goto.login),
              child: TextBody('Join Zendy'),
            )
            // TextBody('Welcome to Zendy'),
          ],
        ));
    });
  }

  Widget _buildDumySearchInput() {
    return Container(
      color: Theme.of(Get.context).backgroundColor,
      child: Gutter(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: TextFormField(
            style: Theme.of(Get.context).textTheme.bodyText1,
            autofocus: false,
            onTap: () {
              Get.toNamed(Goto.search);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context).primaryColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context).primaryColor,
                  width: 1.5,
                ),
              ),
              suffixIcon: _buildSearchIcon(),
              hintText: 'Search for title, subject, author ...',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      splashRadius: 28,
      color: Theme.of(Get.context).primaryColor,
      icon: Icon(CusIcons.search),
      onPressed: () => {Get.toNamed(Goto.search)},
    );
  }
}
