import 'package:defiastra_hackathon/application.dart';
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

enum AppButtonState {
  loading, disable, enable
}

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  const AppButton({
    super.key, this.height = 56.0,
    this.width = double.infinity,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  factory AppButton.primary({
      required String title,
      VoidCallback? onPressed,
      EdgeInsets padding = EdgeInsets.zero,
      Color? backgroundColor,
      Widget? icon,
      double iconPadding = 0.0,
      TextStyle? disableTs,
      TextStyle? enableTs,
      AppButtonState buttonState = AppButtonState.enable
    }) =>
      AppButton(
        padding: padding,
        child: _AppElevatedButton(title: title,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          icon: icon,
          iconPadding: iconPadding,
          disableTs: disableTs,
          enableTs: enableTs,
          buttonState: buttonState,
        ),
      );

  factory AppButton.secondary(
          {required String title,
          VoidCallback? onPressed,
          Color? borderColor,
          Color? textColor,
          EdgeInsets padding = EdgeInsets.zero,
          Widget? icon,
          double iconPadding = 0.0}) =>
      AppButton(
        padding: padding,
        child: _AppElevatedOutlineButton(title: title,
          onPressed: onPressed,
          borderColor: borderColor,
          textColor: textColor,
          icon: icon,
        iconPadding: iconPadding,),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: SizedBox(
          height: height,
          width: width,
          child: child,
        ),
      );
}

class _AppElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Widget? icon;
  final double iconPadding;
  final TextStyle? disableTs;
  final TextStyle? enableTs;
  final AppButtonState buttonState;


  const _AppElevatedButton({required this.title,
    this.onPressed,
    this.backgroundColor,
    this.icon,
    this.iconPadding = 0.0,
    this.disableTs,
    this.enableTs,
    this.buttonState = AppButtonState.enable
  });

  @override
  Widget build(BuildContext context) {
    return _getElevatedButton(context);
  }

  Widget _getElevatedButton(BuildContext context) {
    final appTS = context.textStyles;

    final appColors = context.colors;

    final appDimen = context.dimension;

    final TextStyle disabledTs = disableTs ??
        appTS.uiTextRegular(appColors.background.withOpacity(0.36));

    final TextStyle ts = enableTs ?? appTS.uiTextRegular(appColors.background);

    final Color color = appColors.primary;

    final Color disabledColor = appColors.primary200;

    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appDimen.xsmall))),
          elevation: MaterialStateProperty.all(0),
          textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledTs;
            } else {
              return ts;
            }
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return backgroundColor?.withOpacity(0.36) ?? disabledColor;
            } else {
              return backgroundColor ?? color;
            }
          })),
      onPressed: buttonState == AppButtonState.disable
          ? null
          : () {
            if (buttonState == AppButtonState.enable) {
              onPressed?.call();
            }
          },
      child: buttonState == AppButtonState.loading
          ? CircularProgressIndicator(
            color: appColors.backgroundLight,
          )
          : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              SizedBox(width: iconPadding,),
              Text(title, style: ts,)
            ],
          ),
    );
  }
}

class _AppElevatedOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? textColor;
  final Widget? icon;
  final double iconPadding;

  const _AppElevatedOutlineButton({
    required this.title,
    this.onPressed,
    this.borderColor,
    this.textColor,
    this.icon,
    this.iconPadding = 0.0
  });

  @override
  Widget build(BuildContext context) {
    return _getElevatedButton(context);
  }

  Widget _getElevatedButton(BuildContext context) {

    final appTS = context.textStyles;

    final appColors = context.colors;

    final appDimen = context.dimension;

    final Color borderColor = appColors.primary;

    final TextStyle ts = appTS.uiTextRegular(textColor ?? borderColor);

    final TextStyle disabledTs =
        appTS.uiTextRegular((textColor ?? borderColor).withOpacity(0.36));

    final Color bg = appColors.background;

    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appDimen.xsmall),
            side: BorderSide(color: this.borderColor ?? borderColor)
          )),
          textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return ts;
            } else {
              return disabledTs;
            }
          }),
          backgroundColor: MaterialStateProperty.all(bg)),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const SizedBox(),
          SizedBox(width: iconPadding,),
          Text(title, style: ts,)
        ],
      ),
    );
  }
}
