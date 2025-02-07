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
  ];
}