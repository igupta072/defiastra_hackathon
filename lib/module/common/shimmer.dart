import 'package:defiastra_hackathon/application.dart';
import 'package:defiastra_hackathon/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({super.key, required this.child});

  factory AppShimmer.withPadding(
          {required Widget child, required EdgeInsetsGeometry padding}) =>
      AppShimmer(
        child: Padding(
          padding: padding,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Shimmer.fromColors(
        baseColor: colors.surface3,
        highlightColor: Colors.white,
        child: child
    );
  }
}