import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smart_plans/app/widgets/button_app.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../../core/utils/color_manager.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isPumpOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['text']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 60.h,
              percent: 0.6,
              curve: Curves.easeInOut,
              progressColor: ColorManager.progressColor,
              barRadius: Radius.circular(100.r),
              animation: true,
              animateFromLastPercent: true,
              addAutomaticKeepAlive: true,
              backgroundColor: ColorManager.secondary.withOpacity(.7),
              center: Text(
                '${AppString.age} ${12} / ${50}',
                style: StylesManager.titleBoldTextStyle(
                  size: 20.sp,
                  color: ColorManager.primary,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Container(
              alignment: Alignment.center,
              width: getWidth(context),
              height: 60.h,
              decoration: BoxDecoration(
                  color: ColorManager.secondary,
                  borderRadius: BorderRadius.circular(100.r)),
              child: StatefulBuilder(builder: (context, pumpState) {
                return ListTile(
                  onTap: () {
                    isPumpOn = !isPumpOn;
                    pumpState(() {});
                  },
                  title: Text(
                    AppString.pump + Get.arguments['details']['pump'],
                    style: StylesManager.titleBoldTextStyle(
                        size: 20.sp, color: ColorManager.primary),
                  ),
                  trailing: Switch(
                    thumbColor: MaterialStateProperty.all(ColorManager.primary),
                    activeTrackColor: ColorManager.primary.withOpacity(.5),
                    value: isPumpOn,
                    onChanged: (bool value) {
                      isPumpOn = value;
                      pumpState(() {});
                    },
                  ),
                );
              }),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              Get.arguments['details']['quantity'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  autofocus: true,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s12),
                    border: OutlineInputBorder(),
                  ),
                )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    minimumSize: Size(50.w, 50.w),
                    backgroundColor: ColorManager.secondary,
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    minimumSize: Size(50.w, 50.w),
                    backgroundColor: ColorManager.secondary,
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.remove,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),

            ///
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              Get.arguments['details']['soil'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  autofocus: true,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s12),
                    border: OutlineInputBorder(),
                  ),
                )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    minimumSize: Size(50.w, 50.w),
                    backgroundColor: ColorManager.secondary,
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    minimumSize: Size(50.w, 50.w),
                    backgroundColor: ColorManager.secondary,
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.remove,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),

            ///

            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              Get.arguments['details']['repeat'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            DropdownButtonFormField(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorManager.secondary,
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s12),
                    border: OutlineInputBorder()),
                items: [1, 2, 3, 4]
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            e.toString(),
                            style: StylesManager.titleBoldTextStyle(
                                size: 20.sp, color: ColorManager.primary),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {}),

            const Spacer(),
            ButtonApp(
              text: AppString.apply,
              backgroundColor: ColorManager.secondary,
              textColor: ColorManager.primary,
            )
          ],
        ),
      ),
    );
  }
}
