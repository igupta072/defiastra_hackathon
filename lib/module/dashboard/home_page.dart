import 'package:cached_network_image/cached_network_image.dart';
import 'package:defiastra_hackathon/application.dart';
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:defiastra_hackathon/module/dashboard/home_controller.dart';
import 'package:defiastra_hackathon/module/roulette/page_roulette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';

import '../../widgets/circular_image_holder.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
        actions: [
          IconButton(
            onPressed: () {
              controller.onGetWalletClicked();
            },
            icon: Icon(
              size: 24.r,
              Icons.wallet,
              color: context.colors.surface1,
            )
          )
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: controller.games.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.r,),
        itemBuilder: (_, i) {
          final game = controller.games[i];
          return InkWell(
            onTap: () {
              controller.showTokenBottomSheet().then((token) {
                controller.onGameSelected(game, token);
              });
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: game.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      )
    );
  }
}

class CryptoListWidget extends GetView<HomeController> {
  final List<GroupTokensV2> itemList;

  final Function(GroupTokensV2 token)? onItemTap;

  const CryptoListWidget({super.key, required this.itemList, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    // final VendorTheme theme = Theme.of(context).extension<VendorTheme>()!;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        (itemList.isEmpty)
            ? Column(
          children: [
            Image.asset(
              "assets/images/empty_state_crypto.png",
              height: 144.h,
              width: 144.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Your crypto lives here",
              // style: OktoTextStyle.title3(theme.textPrimaryColor),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Nothing to see here",
              // style: OktoTextStyle.body3(theme.textSecondaryColor),
            ),
          ],
        )
            : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: 32.h,
            ),
            shrinkWrap: true,
            itemCount: itemList.length,
            itemBuilder: (context, idx) {
              GroupTokensV2 tokenItem = itemList[idx];
              return InkWell(
                  onTap: () => onItemTap?.call(tokenItem),
                  child: CryptoListItem(itemModel: tokenItem));
            }),
        SizedBox(
          height: 10.h,
          width: double.infinity,
        ),
      ],
    );
  }
}

class CryptoListItem extends GetView<HomeController> {
  final GroupTokensV2 itemModel;

  const CryptoListItem({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    // final VendorTheme theme = Theme.of(context).extension<VendorTheme>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularImageHolder(
            imagePath: itemModel.tokenImage ?? "",
            isSVG: false,
            height: 56.r,
            width: 56.r),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemModel.name ?? "",
              // style: OktoTextStyle.uiText1(theme.textPrimaryColor),
            ),
            Text(
              "${controller.getCurrentBalance(itemModel)} ${itemModel.symbol}",
              // style: OktoTextStyle.body3(theme.textSecondaryColor),
            ),
          ],
        ),
        Text(
          controller.getTokenPrice(itemModel),
          // style: OktoTextStyle.uiText3(theme.textPrimaryColor),
        )
      ],
    );
  }
}

/*
AppButton.primary(
                  title: "Start roulette",
                  onPressed: () {
                    Get.toNamed(RoulettePage.route);
                  }),
              SizedBox(height: 20.r,),

              AppButton.primary(
                  title: "Selected token",
                  onPressed: () {
                    controller.showTokenBottomSheet();
                  }),

              SizedBox(height: 32.r,),

              AppButton.primary(
                  title: "Get wallets",
                  onPressed: () {
                    controller.onGetWalletClicked();
                  })
 */