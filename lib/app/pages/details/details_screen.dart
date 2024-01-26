
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    child: DetailsContainer(
                  value: '10',
                )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.add,onPressed: (){},),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.remove,onPressed: (){},),
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
                    child: DetailsContainer(value: '20',)),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.add,onPressed: (){},),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.remove,onPressed: (){},),

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
                  color: ColorManager.primary,
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.secondary,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: AppSize.s12),
                    border: OutlineInputBorder(),
                    hintText: 'value'),
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

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        minimumSize: Size(50.w, 50.w),
        backgroundColor: ColorManager.secondary,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: ColorManager.primary,
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: StylesManager.titleNormalTextStyle(
          size: 20.sp, color: ColorManager.primary),
      textAlign: TextAlign.center,
      controller: TextEditingController(text: value),
      onTap: null,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s12),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: ColorManager.secondary),
    );
  }
}
