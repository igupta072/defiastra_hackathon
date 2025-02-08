import 'package:defiastra_hackathon/module/dashboard/home_page.dart';
import 'package:defiastra_hackathon/module/signin/login_page.dart';
import 'package:defiastra_hackathon/network/model/game_table.dart';
import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:defiastra_hackathon/network/repository/game_repository.dart';
import 'package:defiastra_hackathon/util/app_bloc.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';

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