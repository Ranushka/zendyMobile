import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Get.put<AuthController>(
    AuthController(),
    permanent: true,
  );

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

  Get.put<FeaturedContentController>(
    FeaturedContentController(),
    permanent: true,
  );

  Get.put<BySubjectsController>(
    BySubjectsController(),
    permanent: true,
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zendy Reserch',
      theme: customTheme[authController.currentUser.value.theme],
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
        // GetPage(name: Goto.title + ':titleId', page: () => DetailScreen()),
        GetPage(
          name: Goto.citations,
          page: () => SavedCitationsScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.searches,
          page: () => SavedSearchersScreen(),
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
