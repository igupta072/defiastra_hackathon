import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/module/splash/controller_splash.dart';
import 'package:defiastra_hackathon/network/model/game_table.dart';
import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';

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
         AppButton.primary(
           title: "Add Player",
           onPressed: () {
            controller.addToGameTable();
           },
         ),
         SizedBox(height: 20.r,),
         AppButton.primary(
           title: "Update Round",
           onPressed: () {
             final player = Player(id: "800d048a-3058-4357-b5f1-12be09a9ed5b",
                 username: "Indrozz",
                 avatar: "https://cdn-icons-png.flaticon.com/512/6858/6858504.png",
                 hasLeft: false, isActive: true
             );
             controller.updateRound(
                 "5c6ad401-29f0-4adf-b1e4-41ddc03b04a2",
                 Rounds(
                   rn: 2,
                   won: null
                 )
             );
           },
         ),
         SizedBox(height: 20.r,),
         AppButton.primary(
           title: "Update Status",
           onPressed: () {
             controller.updateGameTableStatus(
                 "5c6ad401-29f0-4adf-b1e4-41ddc03b04a2",
                 GameTableStatus.completed
             );
           },
         ),
       ],
     ),
   );
  }
}