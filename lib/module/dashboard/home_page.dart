import 'package:defiastra_hackathon/module/dashboard/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widgets/roulette_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CasinoRoulette(balance: 1000.0, onRoundComplete: (hasWon, amount) {
              if(hasWon) {
                _showWinningDialog(context, amount.toDouble());
              }
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
