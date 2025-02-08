import 'package:defiastra_hackathon/module/dashboard/home_page.dart';
import 'package:defiastra_hackathon/module/roulette/page_roulette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';

class TokenSelectController extends GetxController {

  final TextEditingController searchTextEditingController = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  List<GroupTokensV2> allTokenList;

  RxBool isLoading = true.obs;
  RxBool isError = false.obs;

  String? countryCode;
  String? transactionId;
  String? routeName;

  TokenSelectController({
    this.routeName,
    required this.allTokenList,
  });

  void onTokenTap(GroupTokensV2 token) {
    Get.back(result: token);
  }
}
