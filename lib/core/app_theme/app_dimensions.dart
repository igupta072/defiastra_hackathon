import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_theme.dart';

class AppDimensions extends IDimensions {
  @override
  ThemeExtension<IDimensions> copyWith() {
    return AppDimensions();
  }

  @override
  ThemeExtension<IDimensions> lerp(covariant ThemeExtension<IDimensions>? other, double t) {
    return AppDimensions();
  }

  @override
  double get tiny => 4.r;

  @override
  double get xsmall => 8.r;

  @override
  double get small => 12.r;

  @override
  double get regular => 16.r;

  @override
  double get medium => 20.r;

  @override
  double get xmedium => 24.r;

  @override
  double get large => 30.r;

  @override
  double get xlarge => 36.r;

  @override
  double get radiusLarge => 20.r;

  @override
  double get radiusMedium => 16.r;

  @override
  double get radiusRegular => 8.r;

  @override
  double get radiusSmall => 4.r;

}