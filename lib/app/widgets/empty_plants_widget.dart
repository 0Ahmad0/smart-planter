import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          const SizedBox(height: AppSize.s20,),
          Text(
            AppString.empty,
            style: StylesManager.titleNormalTextStyle(),
          ),
          TextButton(
              onPressed: () {
                Get.toNamed(AppRoute.addPlantRoute);
              },
              child: Text(
                AppString.establishConnection,
                style: TextStyle(
                  decoration: TextDecoration.underline
                ),
              ))
        ],
      ),
    );
  }
}
