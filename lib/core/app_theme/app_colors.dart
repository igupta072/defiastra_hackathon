import 'package:flutter/material.dart';

import 'base_theme.dart';

class AppColorsLight extends IColors {

  @override
  ThemeExtension<IColors> copyWith() {
    return AppColorsLight();
  }

  @override
  ThemeExtension<IColors> lerp(covariant ThemeExtension<IColors>? other, double t) {
    return AppColorsLight();
  }

  @override
  Color get background => const Color(0xFFf7f7f7);

  @override
  Color get primary => const Color(0xFF12416C);

  @override
  Color get secondary => const Color(0xFF446F94);

  @override
  Color get surface1 => const Color(0xFF2C2C2C);

  @override
  Color get surface2 => Colors.grey;

  @override
  Color get bgSnackBar => throw UnimplementedError();

}

class AppColorsDark extends IColors {

  @override
  ThemeExtension<IColors> copyWith() {
    return AppColorsDark();
  }

  @override
  ThemeExtension<IColors> lerp(covariant ThemeExtension<IColors>? other, double t) {
    return AppColorsDark();
  }

  @override
  Color get background => const Color(0xFF2C2C2C);

  @override
  Color get primary => const Color(0xFF422525);

  @override
  Color get secondary => const Color(0xFFFEA70F);

  @override
  Color get surface1 => Colors.white;

  @override
  Color get surface2 => Colors.white70;

  @override
  Color get bgSnackBar => surface2;
}