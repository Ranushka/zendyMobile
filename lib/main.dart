import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zendy_app/helpers/helpers.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/controllers/search_controller.dart';
import 'package:zendy_app/controllers/search_result_controller.dart';
import 'package:zendy_app/controllers/search_history_c.dart';

import 'package:zendy_app/screens/screens.dart';
import 'package:zendy_app/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));

  await Firebase.initializeApp();

  Get.put<SearchController>(
    SearchController(),
    permanent: true,
  );

  Get.put<SearchResultController>(
    SearchResultController(),
    permanent: true,
  );

  Get.put<SearchHistoryController>(
    SearchHistoryController(),
    permanent: true,
  );

  Get.put<SavedCitationsController>(
    SavedCitationsController(),
    permanent: true,
  );

  Get.put<SavedSearchersController>(
    SavedSearchersController(),
    permanent: true,
  );

  Get.put<AuthController>(
    AuthController(),
    permanent: true,
  );

  Get.put<FeaturedContentController>(
    FeaturedContentController(),
    permanent: true,
  );

  Get.put<BySubjectsController>(
    BySubjectsController(),
    permanent: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zendy Demo',
      theme: customTheme['BASE'],
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: Goto.home,
          page: () => HomeScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(name: Goto.settings, page: () => SettingsScreen()),
        GetPage(name: Goto.login, page: () => LoginScreen()),
        GetPage(
          name: Goto.loginEmail,
          transition: Transition.upToDown,
          page: () => LoginEmailScreen(),
        ),
        GetPage(name: Goto.signup, page: () => SignUpScreen()),
        GetPage(name: Goto.title + ':titleId', page: () => DetailScreen()),
        GetPage(
          name: Goto.citations,
          page: () => SavedCitationsScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.searches,
          page: () => UserSavedScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.profile,
          page: () => SettingsScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.search,
          page: () => SearchScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.searchResult,
          page: () => SearchResultScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.webPage,
          page: () => LoadWebScreen(),
          transition: Transition.noTransition,
        ),
      ],
    );
  }
}
