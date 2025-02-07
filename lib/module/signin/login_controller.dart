import 'package:defiastra_hackathon/module/dashboard/home_page.dart';
import 'package:defiastra_hackathon/network/client/firestore/firebase_auth_service.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';

class LoginController extends GetxController {

  final FireStoreAuthService _authService =
      SdkRepositoryProvider().authRepo.getService<FireStoreAuthService>();

  void signInWithGoogle() {
    // OktoSdk().oktoUserClient.client.swa // to
    _authService.signInWithGoogle().then((response) {
      Get.offAllNamed(HomePage.routeName);
    }).onError((e, s) {
      print("$e $s");
    });
  }
}
