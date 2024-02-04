import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/core/route/app_route.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/values_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../models/planet_model.dart';

class AddPlantItemGrid extends StatelessWidget {
   AddPlantItemGrid({
    this.planetModel
  });
  PlanetModel? planetModel;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
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
                    onPressed: () {

                    }, icon: Icon(Icons.add_circle_outline))),
            Expanded(
              child:  planetModel?.url_image!=null?
              Image.network(planetModel?.url_image??''):
              Image.asset('assets/images/strawberries.png'),
            ),
            Text(
              planetModel?.name??
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
