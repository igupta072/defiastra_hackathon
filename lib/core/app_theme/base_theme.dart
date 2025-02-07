import 'package:flutter/material.dart';

abstract class IDimensions extends ThemeExtension<IDimensions> {
  double get tiny;
  double get xsmall;
  double get small;
  double get regular;
  double get medium;
  double get xmedium;
  double get large;
  double get xlarge;

  double get radiusSmall;
  double get radiusMedium;
  double get radiusRegular;
  double get radiusLarge;
}

abstract class IColors extends ThemeExtension<IColors> {

  Color get primary;

  Color get primary50 => primary.withOpacity(0.05);
  Color get primary100 => primary.withOpacity(0.1);
  Color get primary200 => primary.withOpacity(0.2);
  Color get primary300 => primary.withOpacity(0.3);
  Color get primary400 => primary.withOpacity(0.4);
  Color get primary500 => primary.withOpacity(0.5);

  Color get secondary;
  Color get surface1;

  Color get surface2;

  Color get background;
  Color get backgroundDark => const Color(0xFF2C2C2C);

  Color get backgroundLight => const Color(0xFFf7f7f7);

  Color get bgSnackBar;

  Color get alertError => const Color(0xFFFF5353);
  Color get alertSuccess => const Color(0xFF52c41a);
  Color get alertWarning => const Color(0xFFfaad14);
  Color get alertLink => const Color(0xFF1890ff);

  Color get surface3 => surface2.withOpacity(0.2);

  Color get surface6 => const Color(0xFFE5E1E1);

  Color get surface4 => surface2.withOpacity(0.5);

  Color get transparent => Colors.transparent;

  Color get shimmer1 => background.withOpacity(0.12);
}

abstract class ITextStyles extends ThemeExtension<ITextStyles> {
  
  TextStyle uiTextTiny(Color color, {bool bold = false});
  TextStyle uiTextSmall(Color color, {bool bold = false});
  TextStyle uiTextNormal(Color color, {bool bold = false});
  TextStyle uiTextXSmall(Color color, {bool bold = false});
  TextStyle uiTextRegular(Color color, {bool bold = false});
  TextStyle uiTextMedium(Color color, {bool bold = false});
  TextStyle uiTextXMedium(Color color, {bool bold = false});
  TextStyle uiTextLarge(Color color, {bool bold = false});
  TextStyle uiTextXLarge(Color color, {bool bold = false});
}