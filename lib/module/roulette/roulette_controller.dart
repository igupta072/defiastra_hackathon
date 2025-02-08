import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

import '../../network/model/game_table.dart';
import '../../network/model/player.dart';
import '../../network/repository/game_repository.dart';

class RouletteController extends GetxController {

  late final player = Player(
      id: OktoSdk().oktoUserClient?.client.swa,
      username: "Indrozz",
      avatar: "https://cdn-icons-png.flaticon.com/512/6858/6858504.png",
      hasLeft: false,
      isActive: true);

  Future<void> addToGameTable() async {
    try {
      SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .addToGameTable(player: player, type: GameTableType.roulette);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateRound(String tableId, Rounds round) async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateRound(tableId: tableId, round: round);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateGameTableStatus(
      String tableId, GameTableStatus status) async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateTableStatus(tableId: tableId, status: status);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}