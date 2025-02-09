import 'package:defiastra_hackathon/module/roulette/roulette_controller.dart';
import 'package:defiastra_hackathon/util/app_bloc.dart';
import 'package:defiastra_hackathon/widgets/roulette_widget.dart';
import 'package:defiastra_hackathon/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          actions: [
            Obx(
              () => Text(
                'Balance: \$${controller.balance.value}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.fetchPortfolio();
              },
              icon: Icon(
                Icons.refresh,
                size: 32.r,
                color: Colors.black,
              )
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CasinoRoulette(
              balance: double.tryParse(controller.gameArgs.token.balance ?? "0.0") ?? 0.0,
              onRoundComplete: (hasWon, amount) async {
                if (hasWon) {
                  _showWinningDialog(context, amount.toDouble());
                  try {
                    controller.transferWinningFunds(0.02);
                  } catch (e, s) {
                    print(e);
                    print(s);
                  }
                } else {
                  controller.transferToken(0.01);
                }
                await controller.updateRound(hasWon);
                controller.roundAmount = amount;
                await controller.updateGameTableAmount();
              },
            )
          ],
        ));
  }

  void _showWinningDialog(BuildContext context, double winnings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Text(
            'You won \$${winnings.toStringAsFixed(2)}! \nWinning amount will be credited soon.'),
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
