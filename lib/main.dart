import 'package:defiastra_hackathon/application.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/core/sdk_client/sdk_core.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

void main() async {
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
