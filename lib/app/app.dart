import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '/core/utils/app_constant.dart';
import '/core/utils/app_string.dart';
import '/core/utils/theme_manager.dart';

import '../core/route/app_route.dart';
import 'controller/provider/auth_provider.dart';
import 'controller/provider/notification_provider.dart';
import 'controller/provider/plant_provider.dart';
import 'controller/provider/profile_provider.dart';
import 'pages/add_new_plant_screen.dart';
import 'pages/verify_email_screen.dart';

class SmartPlantsApp extends StatelessWidget {
  const SmartPlantsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(AppConstants.designWidth, AppConstants.designHeight),
        builder: (context, child) {
          return MultiProvider(
              providers: [
                Provider<AuthProvider>(create: (_) => AuthProvider()),
                Provider<ProfileProvider>(create: (_) => ProfileProvider()),
                Provider<NotificationProvider>(create: (_) => NotificationProvider()),
                Provider<PlanetModelProvider>(create: (_) => PlanetModelProvider()),
              ],
              child: GetMaterialApp(
                navigatorKey: AppConstants.navigatorKey,
                title: AppString.appName,
                debugShowCheckedModeBanner: false,
                theme: ThemeManager.myTheme,
                home: AddNewPlantScreen(),
                // initialRoute: AppRoute.initialRoute,
                // routes: AppRoute.routesMap,
              ));
        });
  }
}
