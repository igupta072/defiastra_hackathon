import 'package:defiastra_hackathon/module/common/app_dialog.dart';
import 'package:defiastra_hackathon/util/ui_utils.dart';
import 'package:flutter/material.dart';

abstract class IAppDialog<T> {

  AppDialogModel getDialogModel(BuildContext context);

  Future<T?> show(BuildContext context) async {
    onOpen(context);
    final value = await UIUtils().launchDialog(model: getDialogModel(context));
    onClose(value);
    return value;
  }

  void onOpen(BuildContext context) {

  }

  void onClose(T? value) {

  }
}