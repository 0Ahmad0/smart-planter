import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_plans/app/widgets/details_plant_widget.dart';
import 'package:smart_plans/core/utils/app_constant.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';

import '../../core/helper/sizer_media_query.dart';
import '../../core/utils/color_manager.dart';

class MyPlantItem extends StatelessWidget {
  const MyPlantItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: getWidth(context),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(
          24.r,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Image.asset('assets/images/strawberries.png')),
              Container(
                width: getWidth(context),
                height: getWidth(context) / 5,
                color: ColorManager.secondary,
              )
            ],
          ),
          Positioned(
            bottom: (getWidth(context) / 5) / 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppConstants.plantsDetailsList
                  .map(
                    (e) => DetailsPlantWidget(
                      onTap: () {},
                      text: e.text,
                      image: e.image,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}