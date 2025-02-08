import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/module/dashboard/home_controller.dart';
import 'package:defiastra_hackathon/module/roulette/page_roulette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lobby'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton.primary(
                  title: "Start roulette",
                  onPressed: () {
                    Get.toNamed(RoulettePage.route);
                  })
            ]));
  }
}
