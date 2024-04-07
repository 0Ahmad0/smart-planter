import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';

class StylesManager {
  static TextStyle? titleBoldTextStyle({
    color = ColorManager.secondary,
    double size = 48.0,
  }) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size.sp,
      color: color,
    );
  }

  static TextStyle? titleNormalTextStyle({
    color = ColorManager.secondary,
    double size = 30.0,
  }) {
    return TextStyle(
      fontSize: size.sp,
      color: color,
    );
  }

  //
  static borderTextFiled({double width = 1,color = ColorManager.white}) => UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
    borderRadius: BorderRadius.zero
      );
}
