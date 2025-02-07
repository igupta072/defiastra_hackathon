import 'package:defiastra_hackathon/core/app_assets/app_assets.dart';
import 'package:defiastra_hackathon/core/app_theme/app_colors.dart';
import 'package:defiastra_hackathon/core/app_theme/app_dimensions.dart';
import 'package:defiastra_hackathon/core/app_theme/app_textstyles.dart';
import 'package:flutter/material.dart';

@immutable
class AppThemeData {

  final bool isDark;

  late final dimen = AppDimensions();
  late final colors = isDark
      ? AppColorsDark()
      : AppColorsLight();
  late final ts = AppTextStyles();

  AppThemeData({this.isDark = false});

  ThemeData get themeData => ThemeData().copyWith(
    textSelectionTheme: _textSelectionThemeData,
    inputDecorationTheme: _inputDecorationTheme,
    snackBarTheme: _snackBarThemeData,
    appBarTheme: _appBarTheme,
    bottomNavigationBarTheme: _bottomNavigationTheme,
    extensions: [
      dimen,
      colors,
      ts
    ],
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colors.primary
    ),
    iconTheme: IconThemeData(
      color: colors.surface1
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colors.primary;
        } else if (states.contains(MaterialState.disabled)) {
          return colors.surface2;
        } else {
          return colors.background;
        }
      })
    )
  );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: colors.background,
    prefixIconColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.focused)
        ? colors.background
        : colors.surface2),
    contentPadding: EdgeInsets.all(dimen.small),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(dimen.radiusRegular),
    ),
    focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(dimen.radiusRegular),
        borderSide: BorderSide(color: colors.surface1)
    ),
    enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(dimen.radiusRegular),
        borderSide: BorderSide(color: colors.surface2)
    ),
    disabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(dimen.radiusRegular),
        borderSide: BorderSide(color: colors.surface2)
    ),
    errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(dimen.radiusRegular),
        borderSide: BorderSide(color: colors.alertError)
    ),
  );

  TextSelectionThemeData get _textSelectionThemeData => TextSelectionThemeData(
    cursorColor: colors.primary,
    selectionColor: colors.primary,
  );

  SnackBarThemeData get _snackBarThemeData => SnackBarThemeData(
      actionTextColor: colors.background,
      backgroundColor: colors.primary,
      elevation: 4.0,
      contentTextStyle: ts.uiTextSmall(colors.background).copyWith(
        height: 1.2,
        fontFamily: AppFont.poppinsSemiBold.value
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dimen.xsmall)
      )
  );

  BottomNavigationBarThemeData get _bottomNavigationTheme =>
      BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: ts.uiTextSmall(colors.primary).copyWith(height: 1.8),
        unselectedLabelStyle: ts.uiTextSmall(colors.surface1).copyWith(height: 1.8),
        backgroundColor: colors.background,
        showUnselectedLabels: true,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.surface1,
      );

  AppBarTheme get _appBarTheme => AppBarTheme(
        scrolledUnderElevation: 0.0,
        iconTheme: IconThemeData(
          color: colors.surface1,
        ),
        actionsIconTheme: IconThemeData(
          color: colors.surface1
        ),
        backgroundColor: colors.background
      );
}
