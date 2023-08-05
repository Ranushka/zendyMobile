import 'package:get/get.dart';

import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/widgets/widgets.dart';

class Goto {
  static const baseUrl = 'https://zendy-ranushka.vercel.app';
  static const citations = '/user/citation';
  static const home = '/';
  static const login = '/login';
  static const notification = '/notification';
  static const loginEmail = '/login/email';
  static const profile = '/profile';
  static const search = '/search';
  static const searches = '/user/searches';
  static const searchResult = '/search-result';
  static const settings = '/settings';
  static const signup = '/signup';
  static const title = '/title/';
  static const webPage = '/web';
  static const libraryReadScreen = '/library-read';
}

class Api {
  static const _blogUrl = 'https://curated-unify.zendy.io/wp-json/zendy-region';

  static const fromBlog =
      '$_blogUrl/v1/featured_content/oa?rat=en&searchProvider=eds';
  static const featuredContent =
      '$_blogUrl/v1/featured_content/oa?rat=en&searchProvider=eds';
  static const bySubjectsUrl = '$_blogUrl/v1/by_subjects_content/oa?cat=en';
}

void goToWebPage(readLink, downloadLink, {bool noLogin = false}) {
  final AuthController authCtrl = Get.find();

  if (noLogin || authCtrl.isLoggedIn()) {
    Get.toNamed(
      Goto.webPage,
      arguments: {
        'read': readLink,
        'download': downloadLink,
      },
    );
  } else {
    loginToProceed();
  }
}
