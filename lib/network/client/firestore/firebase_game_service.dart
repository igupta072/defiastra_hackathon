import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:defiastra_hackathon/network/client/firestore/base_service.dart';
import 'package:defiastra_hackathon/network/model/game_table.dart';
import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';

class FirebaseGameService extends IFirebaseDatabaseService {
  FirebaseGameService({required super.config});

  @override
  String get dbName => "game_table";

  Future<GameTable> addToGameTable({required Player player, required GameTableType type}) async {
    try {
      switch (type) {
        case GameTableType.roulette:
          final gameTable = GameTable(
            id: SdkRepositoryProvider().uuidV4,
            type: type.name,
            seats: [player],
            status: GameTableStatus.inProgress.name,
            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          );
          await collectionRef.doc(gameTable.id).set(gameTable.toJson());
          return gameTable;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRound({required String tableId, required Rounds round}) async {
    try {

      await collectionRef.doc(tableId).update({
        "rounds" : FieldValue.arrayUnion([
          round.toJson()
        ])
      });

    } catch(e) {
      rethrow;
    }
  }

  Future<void> updateTableStatus({required String tableId, required GameTableStatus status}) async {
    try {

      await collectionRef.doc(tableId).update({
        "status" : status.name
      });

    } catch(e) {
      rethrow;
    }
  }

  Future<void> updateAmount({required String tableId, required num amount}) async {
    try {

      await collectionRef.doc(tableId).update({
        "amount" : FieldValue.increment(amount)
      });

    } catch(e) {
      rethrow;
    }
  }
}