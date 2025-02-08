import 'package:defiastra_hackathon/module/dashboard/token_select_controller.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';

import '../../widgets/common_bottom_sheet.dart';
import 'home_page.dart';


class TokenSelectBottomsheet extends GetView<TokenSelectController> {
  final List<GroupTokensV2> allTokenList;

  const TokenSelectBottomsheet(
      {super.key, required this.allTokenList});

  String getEmptyTitle() {
    return controller.searchTextEditingController.text.isEmpty
        ? "No tokens available"
        : "No results found";
  }

  String getEmptyDescription() {
    return controller.searchTextEditingController.text.isEmpty
        ? 'You don\'t have any balance in your wallet'
        : "Try searching a different token";
  }

  @override
  Widget build(BuildContext context) {

    Get.put(TokenSelectController(allTokenList: allTokenList));

    return DraggableScrollableSheet(
        initialChildSize: .90,
        maxChildSize: .92,
        minChildSize: .6,
        builder: (BuildContext context, ScrollController scrollController) {
          return CommonBottomSheet(
            // backGroundColor: theme.backgroundColor,
            enableBack: false,
            title: "Send",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20.r),
                  decoration: BoxDecoration(
                      // color: theme.backgroundColor,
                      borderRadius: SmoothBorderRadius.only(
                        topLeft: SmoothRadius(
                          cornerRadius: 20.r,
                          cornerSmoothing: 1,
                        ),
                        topRight: SmoothRadius(
                          cornerRadius: 20.r,
                          cornerSmoothing: 1,
                        ),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "YOUR TOKENS",
                            // style: OktoTextStyle.callout1(
                            //     theme.textSecondaryColor),
                          ),
                          Text(
                            "WEB3 BALANCE",
                            // style: OktoTextStyle.callout1(
                            //     theme.textSecondaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.r,
                      ),
                      CryptoListWidget(
                        itemList: controller.allTokenList,
                        onItemTap: (GroupTokensV2 token) {
                          controller.onTokenTap(token);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
