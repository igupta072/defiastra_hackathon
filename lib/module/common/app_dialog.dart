import 'package:defiastra_hackathon/core/app_assets/app_assets.dart';
import 'package:defiastra_hackathon/core/app_theme/base_theme.dart';
import 'package:defiastra_hackathon/module/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';

class AppDialogModel {
  final VoidCallback? onClose;
  final String? title;
  final String? cta1;
  final String? cta2;
  final String body;
  final VoidCallback? cta1Pressed;
  final VoidCallback? cta2Pressed;
  final bool shouldShowCloseIcon;
  final String? image;
  final double? width;
  final double? height;
  final double innerPadding;
  final Widget? custom;
  final bool onBackDismissal;
  final bool barrierDismissible;
  final double? imageSize;

  AppDialogModel({
    this.onClose,
    this.title,
    this.cta1,
    this.cta2,
    this.cta1Pressed,
    this.cta2Pressed,
    this.shouldShowCloseIcon = true,
    this.body = "",
    this.image,
    this.width,
    this.height,
    this.innerPadding = 10.0,
    this.custom,
    this.barrierDismissible = false,
    this.onBackDismissal = false,
    this.imageSize});
}

class AppDialog extends StatelessWidget {

  final AppDialogModel model;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  const AppDialog({super.key, required this.model, this.padding, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: padding,
      backgroundColor: backgroundColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: Container(
        width: model.width,
        height: model.height,
        padding: EdgeInsets.all(model.innerPadding),
        child: Column(
          mainAxisSize: model.height == null
              ? MainAxisSize.min
              : MainAxisSize.max,
          children: [
            model.title?.isNotEmpty == true
                ? _header(context)
                : const SizedBox(),
            model.custom ?? _nonCustom(context)
          ],
        ),
      ),
    );
  }

  Widget _nonCustom(BuildContext context) {
    final dimen = context.dimension;
    return Column(
      mainAxisSize: model.height == null ? MainAxisSize.min : MainAxisSize.max,
      children: [
        SizedBox(height: 16.r,),
        _image(context),
        SizedBox(height: model.image == null ? 0.0 : dimen.small,),
        _body(context),
        SizedBox(height: dimen.xlarge),
        _actions(context)
      ],
    );
  }

  Widget _header(BuildContext context) {
    final dimen = context.dimension;
    final ts = context.textStyles;
    final colors = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(width: model.shouldShowCloseIcon ? 24.0 : 0.0,),
        Expanded(
          child:Text(
            model.title ?? "",
            style: ts.uiTextMedium(colors.surface1, bold: true),
            textAlign: TextAlign.center,),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            model.onClose?.call();
          },
          child: model.shouldShowCloseIcon
              ? Icon(
                  Icons.close_rounded,
                  size: 24.0.r,
                )
              : const SizedBox(),
        ),
        SizedBox(height: dimen.small,)
      ],
    );
  }
  
  Widget _image(BuildContext context) => model.image != null
      ? model.image!.contains("asset")
          ? Image.asset(model.image!, fit: BoxFit.contain, width: model.imageSize ?? 300, height: model.imageSize ?? 300,)
          : Image.network(model.image!, fit: BoxFit.contain, width: 350, height: 450,)
      : const SizedBox();

  Widget _body(BuildContext context) {
    final ts = context.textStyles;
    final colors = context.colors;

    return Text(
      model.body,
      textAlign: TextAlign.center,
      style: ts
          .uiTextRegular(colors.surface1),
    );
  }

  Widget _actions(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      model.cta1 != null ? Expanded(child: AppButton.primary(
          title: model.cta1!,
          enableTs: context.textStyles.uiTextRegular(
              context.colors.background
          ).copyWith(fontFamily: AppFont.poppinsSemiBold.value),
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          onPressed: () {
            model.cta1Pressed?.call();
          }),
      ) : const SizedBox(),
      model.cta2 != null ? Expanded(child: AppButton.primary(
        title: model.cta2!,
        enableTs: context.textStyles.uiTextRegular(
            context.colors.background
        ).copyWith(fontFamily: AppFont.poppinsSemiBold.value),
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        onPressed: () {
          model.cta2Pressed?.call();
        },
      )) : const SizedBox()
    ],
  );
}