
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameInitialCircularWidget extends StatelessWidget {

  final String firstName;
  final String? lastName;

  const NameInitialCircularWidget({
    super.key,
    required this.firstName,
    this.lastName
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.surface4,
      ),
      alignment: Alignment.center,
      child: Text(
        "${firstName[0].toUpperCase()}${lastName?[0].toUpperCase() ?? ''}",
        style: context.textStyles.uiTextMedium(context.colors.surface1, bold: true),
      ),
    );
  }
}