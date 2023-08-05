import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/screens/notification_screen.dart';
import 'package:zendy/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<AuthController>(
    AuthController(),
    permanent: true,
  );

  Get.put<SavedSearchersController>(
    SavedSearchersController(),
    permanent: true,
  );

  Get.put<CustomSearchController>(
    CustomSearchController(),
    permanent: true,
  );

  Get.put<SearchResultController>(
    SearchResultController(),
    permanent: true,
  );

  // Get.put<SearchHistoryController>(
  //   SearchHistoryController(),
  //   permanent: true,
  // );

  Get.put<LibraryController>(
    LibraryController(),
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

  // final AuthController authController = Get.find();
  // final isDark = authController.currentUser.value.theme == 'DARK';

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.blue,
  //   statusBarBrightness: Brightness.dark,
  // ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.find();

  MyApp({super.key});

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
          name: Goto.notification,
          transition: Transition.noTransition,
          page: () => NotificationScreen(),
        ),
        GetPage(name: Goto.loginEmail, page: () => LoginEmailScreen()),
        GetPage(name: Goto.signup, page: () => SignUpScreen()),
        // GetPage(name: Goto.title + ':titleId', page: () => DetailScreen()),
        GetPage(
          name: Goto.citations,
          page: () => const LibraryScreen(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: Goto.searches,
          page: () => const SavedSearchersScreen(),
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
        GetPage(
          name: Goto.libraryReadScreen,
          page: () => const LibraryReadScreen(),
          transition: Transition.noTransition,
        ),
      ],
    );
  }
}
