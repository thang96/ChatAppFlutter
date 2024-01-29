import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/pages/home_page/home_page.dart';
import 'package:chat_app/pages/login_page/login_page.dart';
import 'package:chat_app/pages/profile_page/profile_page.dart';
import 'package:chat_app/pages/splash_page/splash_page.dart';
import 'package:get/get.dart';

import 'app_router.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRouter.root,
        page: () => SplashPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: AppRouter.login,
        page: () => LoginPage(),
        transition: Transition.native),
    GetPage(
        name: AppRouter.home,
        page: () => HomePage(),
        transition: Transition.size),
    GetPage(
        name: AppRouter.pro_file,
        page: () => ProFilePage(),
        transition: Transition.circularReveal),
  ];
}
