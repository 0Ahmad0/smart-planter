import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/controller.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../core/helper/sizer_media_query.dart';
import '../../core/route/app_route.dart';
import '../../core/utils/app_constant.dart';
import '../../core/utils/color_manager.dart';
import '../controller/provider/plant_provider.dart';
import 'details_plant_widget.dart';

class AddNewPlant extends StatelessWidget {
  const AddNewPlant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ListController listController = Get.find();
    return Center(
      child: Container(
        margin: EdgeInsets.all(AppMargin.m16),
        clipBehavior: Clip.hardEdge,
        width: getWidth(context),
        height: getHeight(context) / 2,
        decoration: BoxDecoration(
          color: ColorManager.secondary.withOpacity(.3),
          border: Border.all(color: ColorManager.secondary, width: 2),
          borderRadius: BorderRadius.circular(
            24.r,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular( 24.r),
              onTap: (){
                Get.toNamed(AppRoute.addPlantRoute);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    AssetsManager.addPlantIMG,
                  ),
                  Text(
                    AppString.addPlant,
                    style: StylesManager.titleBoldTextStyle(size: 20.sp),
                  ),
                  const Spacer(),
                  Container(
                    width: getWidth(context),
                    height: getWidth(context) / 5,
                    color: ColorManager.secondary,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: (getWidth(context) / 5) / 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                 AppConstants.plantsDetailsList
                    .map(
                      (e) => DetailsPlantWidget(
                        onTap: null,
                        active: false,
                        text: e.text,
                        image: e.image,
                      ),
                    )
                    .toList(),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  //showEmpty
                  context.read<PlanetModelProvider>().planetModelsApi.planetModels.clear();
                  context.read<PlanetModelProvider>().notifyListeners();
                  listController.listTemp.clear();
                },
                icon: Icon(
                  Icons.close,
                  color: ColorManager.secondary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
