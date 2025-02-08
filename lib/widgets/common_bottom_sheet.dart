import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet(
      {Key? key,
      this.title,
      required this.child,
      this.titleSuffix,
      this.titleChip,
      this.showDrawer = true,
      this.showCrossIcon = false,
      this.onClose,
      this.backGroundColor = Colors.white,
      this.onCrossClicked,
      this.enableBack = true})
      : super(key: key);
  final String? title;
  final Widget child;
  final Color backGroundColor;
  final Widget? titleSuffix;
  final Widget? titleChip;
  final bool? showDrawer;
  final bool showCrossIcon;
  final Function? onClose;
  final Function? onCrossClicked;
  final bool enableBack;

  @override
  Widget build(BuildContext context) {
    // final VendorTheme theme = Theme.of(context).extension<VendorTheme>()!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        color: backGroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.15),
            spreadRadius: 6,
            blurRadius: 18,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  enableBack
                      ? InkWell(
                          onTap: Get.back,
                          child: SvgPicture.asset(
                            "assets/svg_assets/arrow_back.svg",
                            // color: theme.textPrimaryColor,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    width: 8.r,
                  ),
                  title != null
                      ? Text(
                          title!,
                          // style: OktoTextStyle.title3(theme.textPrimaryColor),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}

class BottomSheetCrossIconWidget extends StatelessWidget {
  final String semanticLabel;
  final bool isCrossIconHidden;
  final Function onClicked;

  const BottomSheetCrossIconWidget({
    Key? key,
    required this.isCrossIconHidden,
    required this.semanticLabel,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.h,
      right: 10.h,
      child: isCrossIconHidden
          ? SizedBox(height: 44.h)
          : IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                onClicked.call();
              },
              icon: const Icon(Icons.close_rounded),
            ),
    );
  }
}
