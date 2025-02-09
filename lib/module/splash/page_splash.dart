import 'package:defiastra_hackathon/core/app_assets/app_assets.dart';
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
     body: Center(
       child: Container(
           width: 250.r,
           height: 250.r,
           decoration: BoxDecoration(
               shape: BoxShape.circle,
               image: DecorationImage(
                   fit: BoxFit.cover,
                   image: AssetImage(
                     "assets/images/casino_crypto.webp",
                   )
               )
           )
       ),
     ),
   );
  }
}