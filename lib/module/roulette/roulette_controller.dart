import 'package:defiastra_hackathon/module/dashboard/game_table_controller.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

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
}