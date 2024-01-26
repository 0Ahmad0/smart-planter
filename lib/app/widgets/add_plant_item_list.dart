import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/app/controller/plant_controller.dart';
import 'package:smart_plans/app/models/planet_model.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../core/route/app_route.dart';
import '../../core/utils/styles_manager.dart';
import '../controller/controller.dart';

class AddPlantItemList extends StatefulWidget {
  const AddPlantItemList({
    super.key,
  });

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
    final ListController listController = Get.find();
    return InkWell(
      onTap: () async {
       // await plantController.addPlant(context,
       //    plantId: 0,
       //    common_name: "Evergreen oak",
       //    urlIMG: "https://d2seqvvyy3b8p2.cloudfront.net/40ab8e7cdddbe3e78a581b84efa4e893.jpg",
       //    days_to_harvest: 8,
       //    description: "Quercus rotundifolia",
       //    ph_minimum: 5000,
       //    ph_maximum: 6800,
       //    light: 10,
       //    soil_humidity: 10,
       //    soil_nutriments: 10,
       //    maximum_temperature: 40,
       //    minimum_temperature: 20,
       //  );
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
