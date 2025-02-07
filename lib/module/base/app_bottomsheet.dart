import 'package:defiastra_hackathon/util/ui_utils.dart';
import 'package:flutter/material.dart';

abstract class IAppBottomSheet<T> {
  String get name;
  String? get title;

  Widget getContent(BuildContext context);

  Future<T?> show(BuildContext context,
      {isDismissible = false,
      enableDrag = true,
      bool isBackPressDismissible = true}) async {
    onOpen(context);
    final value = await UIUtils().openBottomSheet<T>(
        context: context,
        title: title,
        name: name,
        isDismissible: isDismissible,
        isBackPressDismissible: isBackPressDismissible,
        enableDrag: enableDrag,
        child: getContent(context)
    );
    onClose(value);
    return value;
  }

  void onOpen(BuildContext context) {

  }

  void onClose(T? value) {

  }
}