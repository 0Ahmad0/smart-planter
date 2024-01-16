import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../core/route/app_route.dart';
import '../../core/utils/styles_manager.dart';
import '../controller/controller.dart';

class AddPlantItemList extends StatelessWidget {
  const AddPlantItemList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ListController listController = Get.find();
    return InkWell(
      onTap: (){
        listController.add();
        Get.offAllNamed(AppRoute.homeRoute);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppSize.s10),
        padding: EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
          color: ColorManager.secondary,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              padding: const EdgeInsets.all(AppPadding.p10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: ColorManager.primary.withOpacity(.5),
              ),
              child: Image.asset('assets/images/strawberries.png'),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  'Name',
                  style: StylesManager.titleNormalTextStyle(
                    color: ColorManager.black,
                    size: 24.sp
                  ),
                ),
                trailing:
                   Icon(Icons.add_circle_outline),

              ),
            )
          ],
        ),
      ),
    );
  }
}
