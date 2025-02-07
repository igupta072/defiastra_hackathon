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
        id: "0xd4397B97cFe9Abbe727cEAf169bCa8bcF72f4aE9",
        privateKey: "",
        maxPriorityFeePerGas: "0x3b9aca00",
        maxFeePerGas: "0x3b9aca00",
        apiKey: "",
        jobManagerAddress: "",
        entryPointContractAddress: ""
    )
  );
  runApp(const Application());
}
