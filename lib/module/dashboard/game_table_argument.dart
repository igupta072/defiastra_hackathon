import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';

class GameTableArgument {
  final GroupTokensV2 token;
  final Player player;

  const GameTableArgument({
    required this.token,
    required this.player,
  });
}