import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlexibleHorizontalListView extends StatelessWidget {
  final Widget Function(BuildContext, int)? itemBuilder;
  final Widget? separator;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  const FlexibleHorizontalListView({super.key,
    required this.itemBuilder,
    this.separator,
    this.itemCount = 0,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.physics
  }) : assert(itemBuilder != null);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    controller: controller,
    physics: physics,
    scrollDirection: Axis.horizontal,
    padding: padding,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(
        itemCount,
        (index) => Builder
        (builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemBuilder!.call(context, index),
              (index >= 0 && index < itemCount - 1)
                  ? separator ?? const SizedBox()
                  : const SizedBox()
            ],
          );
        })
      ),
    ),
  );
}
