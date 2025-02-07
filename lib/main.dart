import 'package:defiastra_hackathon/application.dart';
import 'package:defiastra_hackathon/network/client/firestore/auth_service.dart';
import 'package:defiastra_hackathon/util/app_utility.dart';
import 'package:defiastra_hackathon/util/enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okto_network_manager/service_config.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/core/sdk_client/sdk_core.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (AppUtility.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCZFznVvHJputchH59Sa0-CyPBBcLl8kw0",
            appId: "1:81368794175:android:2887640cf11b1ce32aa48a",
            messagingSenderId: "81368794175",
            projectId: "defi-astra"));
  }

  final baseUrl = AppUtility.getBaseUrl(BuildType.staging);
  final serviceConfig = ServiceConfig(
      appName: "okto_sdk",
      baseUrls: <String, String>{
        "bff": baseUrl,
        "auth": baseUrl,
        "portfolio": baseUrl,
        "oms": baseUrl
      },
      rpcBaseUrl: AppUtility.getRpcBaseUrl(BuildType.staging));

  await OktoSdk().init(
      OktoCore(
          swa: "0x6b6Fad2600Bc57075ee560A6fdF362FfefB9dC3C", // known
          privateKey:
              "2aaa089f7e26ad3d2da3518e1e945d76804372b6bdd044c7f059598c31fa7dcc",
          maxPriorityFeePerGas: "0xBA43B7400",
          maxFeePerGas: "0xBA43B7400",
          apiKey: "b7a36ee9-80e3-4063-b2a1-f9f482a8db51",
          jobManagerAddress: "0xed8Fe2543exfFF64FC3567B03b612AA82C409579a",
          entryPointContractAddress:
              "0xb0C42f19bBb23E52f75813404eeEc0D189b3A61B"),
      oktoServiceConfig: serviceConfig);

  SdkRepositoryProvider()
      .authRepo
      .services
      .add(FireStoreAuthService(config: serviceConfig));
  runApp(const Application());
}
