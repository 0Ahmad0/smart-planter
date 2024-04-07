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

                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.75),
                    blurRadius: 12.0,
                  )
                ],
                  color: active ? ColorManager.gradientColor2 : ColorManager.grey,
                  borderRadius: BorderRadius.circular(14.r)),
              child: Text(
                text,
                style: StylesManager.titleBoldTextStyle(
                  size: 22.sp,
                  color: ColorManager.white
                ),
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
                    width: 2.5,
                  ),
                  color: active ? ColorManager.gradientColor2 : ColorManager.grey,
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

class DetailsPlantLineWidget extends StatelessWidget {
  const DetailsPlantLineWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.image,
    required this.label,
    this.active = true,
  });

  final VoidCallback? onTap;
  final String text;
  final String image;
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(
                  top: AppMargin.m30, left: AppMargin.m30),
              padding: const EdgeInsets.only(
                left: AppPadding.p20,
              ),
              decoration: BoxDecoration(
                  color: active ? ColorManager.primary : ColorManager.grey,
                  borderRadius: BorderRadius.circular(14.r)),
              child: ListTile(
                title: Text(
                  label,
                  style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p8),
                  child: Text(
                    text,
                    style: StylesManager.titleBoldTextStyle(size: 18.sp),
                  ),
                ),
              )),
          Positioned(
            bottom: 6.0,
            left: 0.0,
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
