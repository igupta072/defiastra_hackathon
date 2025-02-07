import 'package:defiastra_hackathon/application.dart';
import 'package:defiastra_hackathon/util/app_utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/core/sdk_client/sdk_core.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO by @Shubham to update this
  if (AppUtility.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "",
            appId: "",
            messagingSenderId: "",
            projectId: ""
        )
    );
  }
  await SdkRepositoryProvider().initialize();
  await OktoSdk().init(
    OktoCore(
        id: "0x6b6Fad2600Bc57075ee560A6fdF362FfefB9dC3C",
        privateKey: "2aaa089f7e26ad3d2da3518e1e945d76804372b6bdd044c7f059598c31fa7dcc",
        maxPriorityFeePerGas: "0xBA43B7400",
        maxFeePerGas: "0xBA43B7400",
        apiKey: "b7a36ee9-80e3-4063-b2a1-f9f482a8db51",
        jobManagerAddress: "0xed8Fe2543efFF64FC3567B03b612AA82C409579a",
        entryPointContractAddress: "0xb0C42f19bBb23E52f75813404eeEc0D189b3A61B"
    )
  );
  runApp(const Application());
}
