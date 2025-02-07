// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:defiastra_hackathon/network/client/firestore/firebase_game_service.dart';
import 'package:defiastra_hackathon/network/model/game_table.dart';
import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:defiastra_hackathon/main.dart';
import 'package:okto_network_manager/service_config.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCZFznVvHJputchH59Sa0-CyPBBcLl8kw0",
          appId: "1:81368794175:android:2887640cf11b1ce32aa48a",
          messagingSenderId: "81368794175",
          projectId: "defi-astra"
      )
  );

  testWidgets('Firebase DB test', (WidgetTester tester) async {
    final service =
        FirebaseGameService(config: ServiceConfig(appName: "", baseUrls: {}));

    await service.addToGameTable(
        player: Player(
          id: "1",
          username: "indrozz",
          avatar: "https://cdn-icons-png.flaticon.com/512/6858/6858504.png",
          hasLeft: false,
          isActive: true,
        ),
        type: GameTableType.roulette
    );
  });
}
