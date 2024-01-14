import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../../core/utils/app_constant.dart';

class MonitorDetailsScreen extends StatelessWidget {
  const MonitorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments['text'],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: getWidth(context),
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(
                    24.r,
                  )),
              child: Image.asset('assets/images/strawberries.png'),
            ),
            const SizedBox(height: AppSize.s20,),
            CarouselSlider(
              options: CarouselOptions(
                height: 150.h,
                viewportFraction: .35,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
              ),
              items: AppConstants.plantsList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 150.w,
                      height: 150.w,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(20.r)
                      ),
                      child: Image.asset('assets/images/strawberries.png'),
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
