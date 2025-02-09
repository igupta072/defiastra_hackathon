import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/token_transfer_user_operation.dart';
import 'package:okto_sdk/network/models/client/order_history_model_v2.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';
import 'package:okto_sdk/util/crypto_utility.dart';

import '../../network/model/game_table.dart';
import '../../network/repository/game_repository.dart';
import '../../util/enums.dart';
import '../dashboard/game_table_controller.dart';

class RouletteController extends GameTableController {

  final Rx<GameTable?> _gameTable = Rx(null);
  int _roundNumber = 0;
  num roundAmount = 0;
  final RxDouble balance = 0.0.obs;

  RouletteController({required super.gameArgs});

  @override
  void onInit() async {
    _gameTable.value = await addToGameTable();
    balance.value = double.tryParse(gameArgs.token.holdingsPriceUsdt ?? "0.0") ?? 0.0;
    super.onInit();
  }

  Future<GameTable> addToGameTable() async {
    try {
      final gt =  await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .addToGameTable(player: gameArgs.player, type: GameTableType.roulette);

      return gt;
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }

  Future<void> updateRound(bool isWon) async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateRound(
              tableId: _gameTable.value!.id!,
              round: Rounds(rn: ++_roundNumber, won: isWon ? gameArgs.player : null));
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateGameTableStatus() async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateTableStatus(
              tableId: _gameTable.value!.id!,
              status: GameTableStatus.completed);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateGameTableAmount() async {
    try {
      await SdkRepositoryProvider()
          .provide<GameRepository>()
          .firebaseGameService
          .updateAmount(
          tableId: _gameTable.value!.id!,
          amount: roundAmount);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<String?> transferToken(num amount) async {
    try {
      final transferDetail = TokenTransferDetails(
          recipientWalletAddress: '0x603CD7B8EAbd2c5CE573AEE3371823967aBFB9eC',
          networkId: 'eip155:137',
          tokenAddress: gameArgs.token.tokenAddress,
          amount: amount);
      final userOpResponse =
          await OktoSdk().oktoUserClient?.estimate(transferDetail);
      final response = OktoSdk().oktoUserClient?.execute(userOpResponse!.userOps!);
      orderHistory(offset: 0, limit: 1);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<OrderHistoryDataV2?> orderHistory(
      {int offset = 0,
        int limit = 1,
        String? orderId,
        OrderState? orderState,
        String intentType = 'TOKEN_TRANSFER'
      }) async {
    String? orderStateToPass;
    switch (orderState) {
      case OrderState.pending:
        orderStateToPass = 'PENDING';
      case OrderState.success:
        orderStateToPass = 'SUCCESS';
      case OrderState.failed:
        orderStateToPass = 'FAILED';
        break;
      default:
        orderStateToPass = 'PENDING';
    }
    final response = await OktoSdk().oktoUserClient?.getOrdersHistory(
        page: offset,
        size: limit,
        intentType: intentType,
        orderId: orderId,
        orderState: orderStateToPass);
    return response;
  }

  @override
  void onClose() {
    super.onClose();
    updateGameTableStatus();
  }

  Future<String> transferWinningFunds(num amount) {
    try {
      return CryptoUtility.transferFunds(
          privateKey: "b07d71f7d26232a3c01de9e4ad370884e17f7fa76fc36c3a26399b7889865009",
          recipientAddress: gameArgs.player.id ?? "",
          amount: amount,
          url: "https://polygon-rpc.com",
          chainId: 137
      );
    } catch (e, s) {
      rethrow;
    }
  }

  Future<void> fetchPortfolio() async {
    OktoSdk().oktoUserClient?.getCryptoPortfolio().then((portfolioData) {
      List<GroupTokensV2> cryptoItems = [];
      if (portfolioData.groupTokens?.isNotEmpty ?? false) {
        for (int i = 0; i < (portfolioData.groupTokens?.length ?? 0); i++) {
          var token = portfolioData.groupTokens?[i];
          if (token != null) {
            cryptoItems.add(token);
          }
        }
      }
      final token = cryptoItems.firstWhereOrNull((t) => t.id == gameArgs.token.id);
      if (token != null) {
        balance.value = double.tryParse(token.balance ?? balance.value.toString()) ?? balance.value;
      }
    });
  }
}
