import 'dart:io';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'enums.dart';

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

  static String getBaseUrl(BuildType buildType) {
    switch(buildType) {
      case BuildType.production: {
        return "https://3p.okto.tech";
      }
      case BuildType.sandbox: {
        return "https://sandbox-api.okto.tech";
      }
      default:
        return "https://3p-bff.oktostage.com";
    }
  }

  static String getRpcBaseUrl(BuildType buildType) {
    return "https://okto-gateway.oktostage.com";
  }

  static String getFormattedNumberString(
      {dynamic value,
        int? precision,
        bool showCommas = false,
        truncatZeros = true,
        bool roundToFloor = false,
        String selectedCurrency = ''}) {
    String _getFixedString(Decimal d, int precision) {
      String num = d.toString();
      if (!num.contains(".")) {
        num += ".0";
      }
      List<String> nums = num.split(".");
      if (precision == 0) {
        return nums[0];
      }
      if (precision < nums[1].length) {
        nums[1] = nums[1].substring(0, precision);
      } else {
        while (precision > nums[1].length) {
          nums[1] = nums[1] + "0";
        }
      }
      return nums.join(".");
    }

    try {
      Decimal? convertedNum;

      String convertedString;

      if (value.runtimeType == String) {
        convertedNum = Decimal.tryParse(value.replaceAll(",", ""));
      } else {
        convertedNum = Decimal.tryParse(value.toString().replaceAll(",", ""));
      }

      if (convertedNum == null) {
        return "";
      }

      // this will return ciel value for ex: 0.0398 will return 0.04
      // convertedString = convertedNum.toStringAsFixed(precision ?? 0);

      //this will return floor value for ex: 0.0398 will return 0.039
      // convertedString = _getFixedString(convertedNum, precision ?? 0);

      //Scenario 1- Eleminate extra decimal without rounding- truncateToDecimalPlaces, its floor only

      //Scenario 2- Roundoff with ceil, toStringAsFixed will round off

      if (precision != null) {
        if (!roundToFloor) {
          //need to truncate the values
          convertedString = convertedNum.toStringAsFixed(precision);
        } else {
          convertedString = _getFixedString(convertedNum, precision);
        }
      } else {
        convertedString = convertedNum.toString();
      }
      if (showCommas) {
        var formatter = NumberFormat.currency(
            locale: 'INR' == selectedCurrency ? "Hi" : null,
            symbol: "",
            decimalDigits: precision);
        convertedString = formatter.format(num.parse(convertedString));
      }
      if (truncatZeros && convertedString.contains('.')) {
        return convertedString.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      } else {
        return convertedString;
      }
    } catch (e) {
      debugPrint(e.toString());
      return "-";
    }
  }
}