import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/app/controller/plant_controller.dart';
import '/app/models/planet_model.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/values_manager.dart';

import '../../core/route/app_route.dart';
import '../../core/utils/styles_manager.dart';

class AddPlantItemList extends StatefulWidget {
   AddPlantItemList({
    super.key,
  required this.planetModel
  });
  PlanetModel planetModel;
  @override
  State<AddPlantItemList> createState() => _AddPlantItemListState();
}

class _AddPlantItemListState extends State<AddPlantItemList> {
  late PlantController plantController;

  @override
  void initState() {
    plantController = PlantController(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(!widget.planetModel.isAdd)
       await plantController.addPlant(context, planetModel: widget.planetModel,

        );
         Get.offAllNamed(AppRoute.homeRoute);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppSize.s10),
        padding: EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
          color: ColorManager.white,
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
              child:
              widget.planetModel?.url_image!=null?
              Image.network(widget.planetModel?.url_image??''):
              Image.asset('assets/images/strawberries.png'),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  widget.planetModel?.name??
                  'Name',
                  style: StylesManager.titleNormalTextStyle(
                    color: ColorManager.black,
                    size: 24.sp
                  ),
                ),
                trailing:
                    widget.planetModel.isAdd?
                   Icon(Icons.check_circle_outline):
                   Icon(Icons.add_circle_outline),

              ),
            )
          ],
        ),
      ),
    );
  }
}
