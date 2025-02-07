import 'dart:ui';

import 'package:defiastra_hackathon/core/app_assets/app_assets.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_theme.dart';

class AppTextStyles extends ITextStyles {

  @override
  ThemeExtension<ITextStyles> copyWith() {
    return AppTextStyles();
  }

  @override
  ThemeExtension<ITextStyles> lerp(covariant ThemeExtension<ITextStyles>? other, double t) {
    return AppTextStyles();
  }

  @override
  TextStyle uiTextTiny(Color color, {bool bold = false}) {
    return TextStyle(
      fontFamily: bold
          ? AppFont.poppinsSemiBold.value
          : AppFont.poppinsRegular.value,
      fontSize: 4.sp,
      color: color
    );
  }

  @override
  TextStyle uiTextXSmall(Color color, {bool bold = false}) {
    return TextStyle(
        fontFamily: bold
            ? AppFont.poppinsSemiBold.value
            : AppFont.poppinsRegular.value,
        fontSize: 8.sp,
      color: color
    );
  }

  @override
  TextStyle uiTextNormal(Color color, {bool bold = false}) {
    return TextStyle(
        fontFamily: bold
            ? AppFont.poppinsSemiBold.value
            : AppFont.poppinsRegular.value,
        fontSize: 14.sp,
        color: color
    );
  }

  @override
  TextStyle uiTextSmall(Color color, {bool bold = false}) {
    return TextStyle(
        fontFamily: bold
            ? AppFont.poppinsSemiBold.value
            : AppFont.poppinsRegular.value,
        fontSize: 12.sp,
        color: color
    );
  }

  @override
  TextStyle uiTextRegular(Color color, {bool bold = false}) {
    return TextStyle(
        fontFamily: bold
            ? AppFont.poppinsSemiBold.value
            : AppFont.poppinsRegular.value,
        fontSize: 16.sp,
        color: color
    );
  }
  
  @override
  TextStyle uiTextMedium(Color color, {bool bold = false}) {
    return TextStyle(
      fontFamily: bold
          ? AppFont.poppinsSemiBold.value
          : AppFont.poppinsRegular.value,
      fontSize: 20.sp,
      color: color
    );
  }

  @override
  TextStyle uiTextXMedium(Color color, {bool bold = false}) {
    return TextStyle(
        fontFamily: bold
            ? AppFont.poppinsSemiBold.value
            : AppFont.poppinsRegular.value,
        fontSize: 24.sp,
        color: color
    );
  }
  
  @override
  TextStyle uiTextLarge(Color color, {bool bold = false}) {
    return TextStyle(
        fontFamily: bold
            ? AppFont.poppinsSemiBold.value
            : AppFont.poppinsRegular.value,
        fontSize: 28.sp,
        color: color
    );
  }

  @override
  TextStyle uiTextXLarge(Color color, {bool bold = false}) {
    return TextStyle(
      fontFamily: bold
          ? AppFont.poppinsSemiBold.value
          : AppFont.poppinsRegular.value,
      fontSize: 32.sp,
      color: color
    );
  }

}