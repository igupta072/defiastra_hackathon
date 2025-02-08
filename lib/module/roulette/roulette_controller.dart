import 'package:defiastra_hackathon/module/dashboard/game_table_controller.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';
import 'package:okto_sdk/util/crypto_utility.dart';

import '../../network/model/game_table.dart';
import '../../network/model/player.dart';
import '../../network/repository/game_repository.dart';

class RouletteController extends GameTableController {

  final Rx<GameTable?> _gameTable = Rx(null);
  int _roundNumber = 0;
  num roundAmount = 0;

  RouletteController({required super.gameArgs});

  @override
  void onInit() async {
    _gameTable.value = await addToGameTable();
    super.onInit();
  }

  Future<GameTable> addToGameTable() async {
    try {
      final gt =  await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .addToGameTable(player: gameArgs.player, type: GameTableType.roulette);

      return gt;
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }

  Future<void> updateRound(bool isWon) async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateRound(
              tableId: _gameTable.value!.id!,
              round: Rounds(rn: ++_roundNumber, won: isWon ? gameArgs.player : null));
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateGameTableStatus() async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateTableStatus(
              tableId: _gameTable.value!.id!,
              status: GameTableStatus.completed);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateGameTableAmount() async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateAmount(
          tableId: _gameTable.value!.id!,
          amount: roundAmount);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  void onClose() {
    super.onClose();
    updateGameTableStatus();
  }

  Future<String> transferWinningFunds(num amount) {
    try {
      return CryptoUtility.transferFunds(
          privateKey: "4af7746b7a3dedfb07f99702088469a74363be6d3bdf6de7a7cdbf5abbf1c68e",
          recipientAddress: "0xbF803aeE0aC4E3fB8472E8fF97CF8a9f7ffb2e55",
          amount: amount,
          url: "https://polygon-rpc.com"
      );
    } catch (e, s) {
      rethrow;
    }
  }
}