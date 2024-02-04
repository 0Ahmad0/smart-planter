import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/utils/styles_manager.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/values_manager.dart';

class DetailsPlantWidget extends StatelessWidget {
  const DetailsPlantWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.image,
    this.active = true,
  });

  final VoidCallback? onTap;
  final String text;
  final String image;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
              height: 90.h,
              constraints: BoxConstraints(minWidth: 100.w, maxWidth: 110.w),
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(
                top: AppMargin.m30,
                left: AppMargin.m8,
                right: AppMargin.m8,
              ),
              padding: const EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                  color: active ? ColorManager.primary : ColorManager.grey,
                  borderRadius: BorderRadius.circular(14.r)),
              child: Text(
                text,
                style: StylesManager.titleBoldTextStyle(size: 22.sp),
              )),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: AppSize.s60,
              height: AppSize.s60,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.secondary,
                    width: AppSize.s4,
                  ),
                  color: active ? ColorManager.primary : ColorManager.grey,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Image.asset(
                  image,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
