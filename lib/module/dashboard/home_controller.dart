import 'package:defiastra_hackathon/module/dashboard/game_model.dart';
import 'package:defiastra_hackathon/module/dashboard/game_table_argument.dart';
import 'package:defiastra_hackathon/module/dashboard/token_select_bottomsheet.dart';
import 'package:defiastra_hackathon/module/roulette/page_roulette.dart';
import 'package:defiastra_hackathon/network/model/game_table.dart';
import 'package:defiastra_hackathon/network/model/player.dart';
import 'package:defiastra_hackathon/util/app_bloc.dart';
import 'package:defiastra_hackathon/util/app_utility.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/core/repository/sdk_repository_provider.dart';
import 'package:okto_sdk/core/sdk_client/sdk_core.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';
import 'package:okto_sdk/util/crypto_utility.dart';

class HomeController extends GetxController {
  
  late  OktoCoreClient host;

  late final player = Player(
      id: OktoSdk().oktoUserClient?.client.swa,
      username: "Indrozz",
      avatar: "https://cdn-icons-png.flaticon.com/512/6858/6858504.png",
      hasLeft: false,
      isActive: true);

  final List<GameModel> games = [
    GameModel(
      image: "https://res.cloudinary.com/kalispel/image/upload/f_auto,q_auto/v1714690433/Craft%20Images/Roulette_header_2750x1600_jsg1ap.jpg",
      name: "Classic Roulette",
      gameId: "1",
      gameType: GameTableType.roulette.name
    )
  ];

  final RxList<GroupTokensV2> cryptoTokens = <GroupTokensV2>[].obs;
  final Rx<AggregatedDataV2> aggregatedData = AggregatedDataV2().obs;

  @override
  onInit() {
    getWallets();
    _fetchPortfolio();
    super.onInit();
  }

  Future<void> _fetchPortfolio() async {
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
      cryptoTokens.value = cryptoItems;
      aggregatedData.value = portfolioData.aggregatedData ?? AggregatedDataV2();
      AppBloc().balance.value = double.tryParse(aggregatedData.value.holdingsPriceUsdt ?? "0.0") ?? 0.0;
    });
  }

  String getCurrentBalance(GroupTokensV2 itemModel) {
    return AppUtility.getFormattedNumberString(
        value: itemModel.balance,
        showCommas: true,
        selectedCurrency: 'INR',
        precision: int.tryParse(itemModel.precision ?? "8"));
  }

  String getTokenPrice(GroupTokensV2 itemModel) {
    return "₹${itemModel.holdingsPriceInr ?? ''}";
  }

  Future<void> getWallets() async {
    OktoSdk().oktoUserClient?.getWallets().then((wallet) {
      final token = wallet.wallets?.firstWhereOrNull((w) => w.networkName?.toLowerCase() == "polygon");
      player.id = token?.address ?? wallet.wallets?.firstOrNull?.address;
      print("INDRAA :: ${player.id}");
    }).onError((e, s) {
      print("$e $s");
    });
  }

  Future<GroupTokensV2?> showTokenBottomSheet() {
    return Get.bottomSheet<GroupTokensV2?>(
        TokenSelectBottomsheet(allTokenList: cryptoTokens));
  }

  void onGetWalletClicked() {
    getWallets().then((wallets) {

    }).onError((e, s) {

    });
  }

  void onGameSelected(GameModel game, GroupTokensV2? token) {
    if (token == null) return;
    Get.toNamed(
      RoulettePage.route,
      arguments: GameTableArgument(
          token: token,
          player: player
      )
    );
  }
}
