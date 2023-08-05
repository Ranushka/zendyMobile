import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zendy/widgets/app_bar_logo.dart';
import 'package:zendy/widgets/from_blog.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
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
      direction: Axis.vertical,
      children: [
        const CheckConnection(),
        _buildHeroCall(),
        _buildDumySearchInput(),
        const SizedBox(height: 8),
        JoinZendy(),
        const SizedBox(height: 16),
        LatestNewsList(),
        BySubjects(),
        SizedBox(height: 32),
        FromBlog(),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildHeroCall() {
    return Container(
      color: Theme.of(Get.context!).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const SizedBox(height: 16),
          AppBarLogo(),
          const SizedBox(height: 16),
          const Gutter(Title1('Research is creating new knowledge.')),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDumySearchInput() {
    return Container(
      color: Theme.of(Get.context!).colorScheme.background,
      child: Gutter(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: TextFormField(
            style: Theme.of(Get.context!).textTheme.bodyLarge,
            autofocus: false,
            onTap: () {
              Get.toNamed(Goto.search);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context!).primaryColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context!).primaryColor,
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
      color: Theme.of(Get.context!).primaryColor,
      icon: const Icon(FontIcons.search),
      onPressed: () => {Get.toNamed(Goto.search)},
    );
  }
}
