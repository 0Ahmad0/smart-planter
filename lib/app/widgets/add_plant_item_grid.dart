import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../core/utils/styles_manager.dart';
import '../controller/controller.dart';

class AddPlantItemGrid extends StatelessWidget {
  const AddPlantItemGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ListController listController = Get.find();

    return InkWell(
      onTap: () {
        listController.add();
        Get.offAllNamed(AppRoute.homeRoute);
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p6),
        decoration: BoxDecoration(
          color: ColorManager.secondary,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.add_circle_outline))),
            Expanded(
              child: Image.asset(
                'assets/images/strawberries.png',
              ),
            ),
            Text(
              'Name',
              style: StylesManager.titleNormalTextStyle(
                  color: ColorManager.black,
                  size: 24.sp
              ),
            ),
          ],
        ),
      ),
    );
  }
}
