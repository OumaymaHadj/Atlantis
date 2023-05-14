import 'package:chat_res/helper/binding.dart';
import 'package:chat_res/view/home.view.dart';
import 'package:chat_res/view/login.view.dart';
import 'package:chat_res/view/register.view.dart';
import 'package:chat_res/view/splash.screen.dart';
import 'package:get/get.dart';

routes() {
  return [
    GetPage(
      name: "/Splash",
      page: () => const SplashScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: "/Login",
      page: () => LoginView(),
    ),
    GetPage(
      name: "/Register",
      page: () => Register(),
    ),
    GetPage(
      name: "/Home",
      page: () => HomeView(),
    ),
  ];
}