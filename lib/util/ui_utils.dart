import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:defiastra_hackathon/module/common/app_bottomsheet_cointainer.dart';
import 'package:defiastra_hackathon/module/common/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UIUtils {

  static final UIUtils _instance = UIUtils._();
  bool _isShowingLoader = false;
  int _openBottomSheetCount = 0;

  UIUtils._();

  factory UIUtils() => _instance;

  void showSnackBar(String message, {BuildContext? context, SnackBarAction? action, Duration? duration, bool? isSuccess}) {
    //delayed is given so that it shows after the screen is build. In other word make it as low priority for event loop
    Future.delayed(const Duration(seconds: 0), () {
      ScaffoldMessenger.of(context ?? Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: duration ?? const Duration(seconds: 3),
            action: action,
            behavior: SnackBarBehavior.floating,
            backgroundColor: isSuccess != null
                ? isSuccess
                    ? Get.context!.colors.alertSuccess
                    : Get.context!.colors.alertError
                : null ,
          )
      );
    });
  }

  Future<dynamic> launchDialog({
      required AppDialogModel model,
      BuildContext? context,
      Color? backgroundColor,
      EdgeInsets? padding,
      Duration duration = const Duration(milliseconds: 300)}) async {

    return Future.delayed(duration, () {

      if (_isShowingLoader) {
        return Future.value(null);
      }
      _isShowingLoader = true;

      return showDialog(
          barrierDismissible: model.barrierDismissible,
          context: context ?? Get.context!,
          builder: (context) => WillPopScope(
            child: AppDialog(
              model: model,
              padding: padding ?? EdgeInsets.all(16.r),
              backgroundColor: backgroundColor,
            ),
            onWillPop: () => Future.value(model.onBackDismissal)
          ),
          useSafeArea: false,
      ).then((value) {
        _isShowingLoader = false;
        //process queue of dialogs
      });
    });
  }

  void showSessionExpiredDialog(VoidCallback performAction) {
    launchDialog(
      model: AppDialogModel(
        title: "Session Expired",
        body: "You will redirect to login screen!",
        cta1: "OK",
        cta1Pressed: () {
          Get.back();
          performAction();
        },
        shouldShowCloseIcon: false,
      ),
      duration: Duration.zero,
    );
  }

  void showErrorDialog({String error = '', VoidCallback? performAction}) {
    launchDialog(
      model: AppDialogModel(
        title: "Opps!",
        body: error,
        cta1: "OK",
        cta1Pressed: () {
          Get.back();
          performAction?.call();
        },
        shouldShowCloseIcon: false,
      ),
      duration: Duration.zero,
    );
  }

  void showLoader() {
    launchDialog(
      backgroundColor: Colors.transparent,
      model: AppDialogModel(
        custom: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white
          ),
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
        shouldShowCloseIcon: false,
      ),
      duration: Duration.zero,
    );
  }

  void dismissDialog({BuildContext? context}) {
    if (_isShowingLoader) {
      _isShowingLoader = false;
      Get.back();
    };
  }

  bool get isDialogVisible => _isShowingLoader;

  Future<T?> showBottomSheet<T>({
    required String name,
    required Widget Function(BuildContext context, T? value) builder,
    BuildContext? context,
    T? value,
    bool dismissPrevious = false,
    bool dismissAll = false
  }) {

    if (isBottomSheetOpen) {
      if (dismissPrevious) {
        dismissBottomSheet(context: context);
      } else if (dismissAll) {
        while(_openBottomSheetCount > 0) {
          dismissBottomSheet(context: context);
        }
      } else { }
    }

    ++_openBottomSheetCount;
    print("BOTTOMSHEET :: $name OPENED");
    return showModalBottomSheet<T>(
        context: context ?? Get.context!,
        builder: (context) {
          return builder(context, value);
        },
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            )
        )
    ).then((value) {
      if (_openBottomSheetCount > 0) {
        --_openBottomSheetCount;
      }
      print("BOTTOMSHEET :: $name CLOSED");
      return value;
    });
  }

  bool get isBottomSheetOpen => _openBottomSheetCount > 0;

  void dismissBottomSheet({BuildContext? context}) {
    if (isBottomSheetOpen) {
      Get.back();
      --_openBottomSheetCount;
    }
  }

  Future<T?> openBottomSheet<T>({
    required String name,
    required Widget child,
    String? title,
    bool showClose = true,
    bool dismissPrevious = false,
    bool dismissAll = false,
    BuildContext? context,
    bool isDismissible = false,
    bool isBackPressDismissible = true,
    bool enableDrag = true
  }) {
    if (isBottomSheetOpen) {
      if (dismissPrevious) {
        dismissBottomSheet(context: context ?? Get.context!);
      } else if (dismissAll) {
        while(_openBottomSheetCount > 0) {
          dismissBottomSheet(context: context ?? Get.context!);
        }
      } else { }
    }

    ++_openBottomSheetCount;
    print("BOTTOMSHEET :: $name OPENED");
    return showModalBottomSheet(
        context: context ?? Get.context!,
        backgroundColor: Colors.transparent,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        builder: (_) {
          return PopScope(
            canPop: isBackPressDismissible,
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context ?? Get.context!).viewInsets.bottom) ,
                child: AppBottomSheetContainer(
                  title: title,
                  showClose: showClose,
                  child: child ,
                )
            )
          );
        },
        isScrollControlled: true,
    ).then((value) {
      if (_openBottomSheetCount > 0) {
        --_openBottomSheetCount;
      }
      print("BOTTOMSHEET :: $name CLOSED");
      return value;
    });
  }
}