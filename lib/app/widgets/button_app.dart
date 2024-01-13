import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({
    super.key,
    required this.text,
    this.textColor = ColorManager.secondary,
    this.backgroundColor = ColorManager.primary,
    this.onPressed,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: Size(double.infinity, AppSize.s60),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s100.r),
              side: BorderSide(
                  color: ColorManager.secondary, width: AppSize.s4))),
      onPressed: onPressed,
      child: Text(
        text,
        style: StylesManager.titleBoldTextStyle(size: 28.sp, color: textColor),
      ),
    );
  }
}
