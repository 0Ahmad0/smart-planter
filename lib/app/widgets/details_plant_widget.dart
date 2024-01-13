import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/values_manager.dart';

class DetailsPlantWidget extends StatelessWidget {
  const DetailsPlantWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.image,
  });

  final VoidCallback onTap;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
              height: 90.h,
              constraints: BoxConstraints(
                minWidth: 100.w,
                maxWidth: 110.w
              ),
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: AppMargin.m30,left: AppMargin.m8,right: AppMargin.m8,),
              padding: const EdgeInsets.all( AppPadding.p8),
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(14.r)),
              child: Text(text,style: StylesManager.titleBoldTextStyle(
                size: 22.sp
              ),)),
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
                  color: ColorManager.primary,
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
