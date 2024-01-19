import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_constant.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../controller/splashController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //navigation to new screen
  void _goNextScreen() {
    Future.delayed(
      //time navigation
      Duration(seconds: AppConstants.splashDelay),
      () {
        SplashController().init(context);
        //get navigation by screen name
        ///Get.offNamed(AppRoute.loginRoute);
      },
    );
  }

  @override
  void initState() {
    //Hide status bar
    super.initState();
    _goNextScreen();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AssetsManager.splashBackgroundIMG,
            fit: BoxFit.cover,
            width: getWidth(context),
            height: getHeight(context),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.appName,
                style: StylesManager.titleBoldTextStyle(
                  color: ColorManager.white
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              const SpinKitCircle(
                color: ColorManager.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
