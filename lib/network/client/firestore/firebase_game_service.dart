import 'package:defiastra_hackathon/network/client/firestore/base_service.dart';

class FirebaseGameService extends IFirebaseDatabaseService {
  FirebaseGameService({required super.config});

  @override
  String get dbName => "players";


}