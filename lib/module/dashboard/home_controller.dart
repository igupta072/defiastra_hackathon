import 'package:defiastra_hackathon/util/app_utility.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';
import 'package:okto_sdk/okto_flutter_sdk.dart';

class HomeController extends GetxController {

  RxList<GroupTokensV2> cryptoTokens = <GroupTokensV2>[].obs;
  Rx<AggregatedDataV2> aggregatedData = AggregatedDataV2().obs;

  @override
  onInit() {
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
      print(wallet.toJson());
    }).onError((e, s) {
      print("$e $s");
    });
  }

}
