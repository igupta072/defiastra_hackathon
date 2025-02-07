import 'package:defiastra_hackathon/network/client/firestore/base_service.dart';

class FirebasePlayerService extends IFirebaseDatabaseService {
  FirebasePlayerService({required super.config});

  @override
  String get dbName => "players";
}