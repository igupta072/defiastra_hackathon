import 'package:defiastra_hackathon/network/client/firestore/firebase_game_service.dart';
import 'package:okto_network_manager/repository/base_repository.dart';

class GameRepository extends IRepository {
  GameRepository({required super.services});

  late final FirebaseGameService firebaseGameService = getService();
}