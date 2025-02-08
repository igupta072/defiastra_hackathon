import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/module/splash/controller_splash.dart';
import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {

  static const route = "/";

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       mainAxisSize: MainAxisSize.max,
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [

       ],
     ),
   );
  }
}