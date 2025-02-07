import 'package:defiastra_hackathon/module/dashboard/home_page.dart';
import 'package:defiastra_hackathon/module/signin/login_page.dart';
import 'package:defiastra_hackathon/util/app_bloc.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 3), // Change the duration as needed
          () {
        _toHome();
      },
    );
  }

  void _toHome() async {
    if(await AppBloc().isLoggedIn() ) {
      Get.toNamed(HomePage.routeName);
    } else {
      Get.offAllNamed(LoginPage.routeName);
    }
  }
}