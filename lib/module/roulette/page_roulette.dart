import 'dart:math';

import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/module/roulette/roulette_controller.dart';
import 'package:defiastra_hackathon/widgets/roulette_widget.dart';
import 'package:defiastra_hackathon/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoulettePage extends GetView<RouletteController> {

  static const String route = '/roulette';


  RoulettePage({super.key});

  MySpinController mySpinController = MySpinController();

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
            // MySpinner(
            //   mySpinController: mySpinController,
            //   wheelSize: Get.width * 0.8,
            //   itemList: [
            //     RouletteNumber(0, Colors.green), // 0
            //     RouletteNumber(32, Colors.red), RouletteNumber(15, Colors.black),
            //     RouletteNumber(19, Colors.red), RouletteNumber(4, Colors.black),
            //     RouletteNumber(21, Colors.red), RouletteNumber(2, Colors.black),
            //     RouletteNumber(25, Colors.red), RouletteNumber(17, Colors.black),
            //     RouletteNumber(34, Colors.red), RouletteNumber(6, Colors.black),
            //     RouletteNumber(27, Colors.red), RouletteNumber(13, Colors.black),
            //     RouletteNumber(36, Colors.red), RouletteNumber(11, Colors.black),
            //     RouletteNumber(30, Colors.red), RouletteNumber(8, Colors.black),
            //     RouletteNumber(23, Colors.red), RouletteNumber(10, Colors.black),
            //     RouletteNumber(5, Colors.red), RouletteNumber(24, Colors.black),
            //     RouletteNumber(16, Colors.red), RouletteNumber(33, Colors.black),
            //     RouletteNumber(1, Colors.red), RouletteNumber(20, Colors.black),
            //     RouletteNumber(14, Colors.red), RouletteNumber(31, Colors.black),
            //     RouletteNumber(9, Colors.red), RouletteNumber(22, Colors.black),
            //     RouletteNumber(18, Colors.red), RouletteNumber(29, Colors.black),
            //     RouletteNumber(7, Colors.red), RouletteNumber(28, Colors.black),
            //     RouletteNumber(12, Colors.red), RouletteNumber(35, Colors.black),
            //     RouletteNumber(3, Colors.red), RouletteNumber(26, Colors.black),
            //     // SpinItem(label: 'Eggplant', color: Colors.redAccent),
            //     // SpinItem(label: 'Flower', color: Colors.lightBlueAccent),
            //   ],
            // ),
            CasinoRoulette(balance: 1000.0, onRoundComplete: (hasWon, amount) async {
              if(hasWon) {
                _showWinningDialog(context, amount.toDouble());
              }
              await controller.updateRound(hasWon);
              controller.roundAmount = amount;
              await controller.updateGameTableAmount();
            },)
          ],
        ));
  }

  void _showWinningDialog(BuildContext context, double winnings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Text('You won \$${winnings.toStringAsFixed(2)}!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

}