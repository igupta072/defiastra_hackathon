import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:okto_network_manager/network/base_api_service.dart';


abstract class IFirebaseService<T extends FirebasePluginPlatform> extends IService {
  late T _instance;

  IFirebaseService({required super.config});

  T get serviceInstance => _instance ;
}

abstract class IFirebaseDatabaseService extends IFirebaseService<FirebaseFirestore> {

  @override
  late FirebaseFirestore _instance = FirebaseFirestore.instance;

  IFirebaseDatabaseService({required super.config});

  String get dbName;

  CollectionReference<Map<String, dynamic>> get collectionRef =>
      serviceInstance.collection(dbName);
}