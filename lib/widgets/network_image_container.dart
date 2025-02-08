import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NetworkImageContainer extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool? enabled;

  const NetworkImageContainer({
    Key? key,
    required this.imageUrl,
    this.height = 56,
    this.width = 56,
    this.placeholder,
    this.errorWidget,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const ColorFilter greyscale = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    return ClipOval(
      child: ColorFiltered(
        colorFilter: (enabled ?? true)
            ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
            : greyscale,
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 300),
          placeholder: (context, url) => placeholder ?? TokenPlaceholder(
            height: height.r,
            width: width.r,
          ),
          imageUrl: imageUrl,
          height: height.r,
          width: width.r,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) => errorWidget ?? TokenPlaceholder(
            height: height.r,
            width: width.r,
          ),
        ),
      ),
    );
  }
}

class TokenPlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  const TokenPlaceholder({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/svg_assets/token_placeholder.svg",
      height: height ?? 56.r,
      width: width ?? 56.r,
    );
  }
}
