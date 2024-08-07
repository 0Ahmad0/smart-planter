import 'package:flutter/material.dart';
import 'package:smart_plans/core/utils/color_manager.dart';

class GradientContainerWidget extends StatelessWidget {
  const GradientContainerWidget({
    super.key,
    required this.colors,
    this.child,
  });

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //   colors: colors,
      //   end: Alignment.topLeft,
      //   begin: Alignment.bottomRight,
      // )
      color: ColorManager.fwhite),
      child: child,
    );
  }
}
