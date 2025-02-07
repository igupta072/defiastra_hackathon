import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppUtility {
  AppUtility._();

  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isWeb => kIsWeb;

  static String formatWithCommas(
      {num? numberToConvert, num precision = 0}) {
    if (numberToConvert == null) return '';
    String formatter = "#,##,##0.";
    if (precision == 0) {
      formatter = formatter.split(',')[0];
    } else {
      for (num i = 0; i < precision; i++) {
        formatter += '0';
      }
    }

    final oCcy = NumberFormat(formatter, "en_US");
    return oCcy.format(numberToConvert);
  }
}