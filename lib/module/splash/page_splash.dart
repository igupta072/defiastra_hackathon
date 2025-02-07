import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/module/splash/controller_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {

  static const route = "/";

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
     body: AppButton.primary(title: title),
   );
  }
}