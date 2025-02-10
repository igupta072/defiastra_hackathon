import 'package:defiastra_hackathon/module/dashboard/add_funds_screen.dart';
import 'package:defiastra_hackathon/module/dashboard/game_table_argument.dart';
import 'package:defiastra_hackathon/module/dashboard/game_table_controller.dart';
import 'package:defiastra_hackathon/module/dashboard/home_controller.dart';
import 'package:defiastra_hackathon/module/dashboard/home_page.dart';
import 'package:defiastra_hackathon/module/roulette/page_roulette.dart';
import 'package:defiastra_hackathon/module/roulette/roulette_controller.dart';
import 'package:defiastra_hackathon/module/signin/login_controller.dart';
import 'package:defiastra_hackathon/module/signin/login_page.dart';
import 'package:defiastra_hackathon/module/splash/controller_splash.dart';
import 'package:defiastra_hackathon/module/splash/page_splash.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> appRoutePages = [
    GetPage(
        name: SplashPage.route,
        page: () => const SplashPage(),
        binding: BindingsBuilder(() {
          Get.put(SplashController());
        })),

    GetPage(
        name: HomePage.routeName,
        page: () => const HomePage(),
        binding: BindingsBuilder(() {
          Get.put(HomeController());
        })),

    GetPage(
        name: LoginPage.routeName,
        page: () => const LoginPage(),
        binding: BindingsBuilder(() {
          Get.put(LoginController());
        })),

    GetPage(
        name: RoulettePage.route,
        page: () =>  RoulettePage(),
        binding: BindingsBuilder(() {
          Get.put(RouletteController(gameArgs: Get.arguments as GameTableArgument));
        })),

    GetPage(
        name: AddFundsScreen.route,
        page: () =>  AddFundsScreen(address: Get.arguments as String,))
  ];
}