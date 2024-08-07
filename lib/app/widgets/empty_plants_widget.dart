import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/provider/plant_provider.dart';
import 'package:smart_plans/app/models/planet_model.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import '/core/route/app_route.dart';
import '/core/utils/app_string.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/styles_manager.dart';
import '/core/utils/values_manager.dart';

class EmptyPlantsWidget extends StatelessWidget {
  const EmptyPlantsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AssetsManager.emptyIMG),
          const SizedBox(
            height: AppSize.s10,
          ),
          Text(
            AppString.empty,
            style: TextStyle(
                color: ColorManager.appBarColor.withOpacity(0.7), fontSize: 20),
          ),
          TextButton(
              onPressed: () {
                context
                    .read<PlanetModelProvider>()
                    .planetModelsApi
                    .planetModels = [PlanetModel.init()];
                context.read<PlanetModelProvider>().notifyListeners();
                //Get.toNamed(AppRoute.addPlantRoute);
              },
              child: Text(
                AppString.addNewPlant,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: ColorManager.appBarColor.withOpacity(0.8),
                    fontSize: 20),
              ))
        ],
      ),
    );
  }
}
