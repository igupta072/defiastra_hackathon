import 'package:defiastra_hackathon/module/roulette/roulette_controller.dart';
import 'package:defiastra_hackathon/widgets/roulette_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoulettePage extends GetView<RouletteController> {

  static const String route = '/roulette';

  const RoulettePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lobby'),
          actions: [
            Text(controller.gameArgs.token.balance ?? '0', style: TextStyle(),)
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CasinoRoulette(balance: 1000.0, onRoundComplete: (hasWon, amount) async {
              if(hasWon) {
                _showWinningDialog(context, amount.toDouble());
              } else {
                // final jobId = await controller.transferToken(0.01);
                // print("Transfer success: $jobId");
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