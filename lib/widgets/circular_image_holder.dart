import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'network_image_container.dart';

class CircularImageHolder extends StatelessWidget {
  CircularImageHolder(
      {super.key,
      required this.imagePath,
      this.width,
      this.height,
      required this.isSVG});

  double? height;
  double? width;
  bool isSVG;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            // color: theme.backgroundColor,
            width: 2.0,
          ),
          // color: theme.backgroundColor
      ),
      child: isSVG
          ? SvgPicture.asset(
              imagePath,
              height: height ?? 56.r,
              width: width ?? 56.r,
            )
          : NetworkImageContainer(
              imageUrl: imagePath,
              height: height ?? 56.r,
              width: width ?? 56.r,
            ),
    );
  }
}
