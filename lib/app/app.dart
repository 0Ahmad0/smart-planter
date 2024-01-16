import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/app/pages/home_screen.dart';
import 'package:smart_plans/app/pages/splash_screen.dart';
import 'package:smart_plans/core/utils/app_constant.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/theme_manager.dart';

import '../core/route/app_route.dart';

class SmartPlantsApp extends StatelessWidget {
  const SmartPlantsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(AppConstants.designWidth, AppConstants.designHeight),
        builder: (context, child) {
          return GetMaterialApp(
            title: AppString.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.myTheme,
            initialRoute: AppRoute.initialRoute,
            routes: AppRoute.routesMap,
          );
        });
  }
}
