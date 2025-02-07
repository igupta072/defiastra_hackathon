import 'package:defiastra_hackathon/application.dart';
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheetContainer extends StatelessWidget {

  final Widget child;
  final String? title;
  final TextStyle? titleTextStyle;
  final bool showClose;

  const AppBottomSheetContainer({
    super.key,
    required this.child,
    this.title,
    this.showClose = true,
    this.titleTextStyle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
        ),
        Container(
          width: 50.r,
          height: 6.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: context.colors.surface2,
          ),
        ),
        SizedBox(height: 12.r,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            color: context.colors.background
          ),
          child: title?.isNotEmpty == true || showClose ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                  vertical: 20.r
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: titleTextStyle ?? context.textStyles.uiTextRegular(context.colors.surface1, bold: true),
                      ),
                    ),
                    SizedBox(width: 12.r,),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop("close");
                      },
                      child: Icon(
                        Icons.close_rounded,
                        size: 24.r,
                        color: context.colors.surface1,
                      ),
                    ),
                  ],
                ),
              ),
              child,
            ],
          ) : child,
        )
      ],
    );
  }
}