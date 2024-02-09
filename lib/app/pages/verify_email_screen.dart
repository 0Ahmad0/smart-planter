import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_plans/core/route/app_route.dart';
import '/core/utils/assets_manager.dart';
import '../../core/utils/app_string.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import '../controller/auth_controller.dart';
import '../widgets/button_app.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen>{
  late AuthController authController;
  int seconds = 60;
  bool isButtonDisabled = false;
  late Timer timer;

  String getFormattedTime() {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  void startTimer() {
    setState(() {
      isButtonDisabled = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isButtonDisabled = false;
          seconds = 60;
        });
      }
    });
  }

  @override
  void dispose() {

    timer.cancel();
    super.dispose();
  }


  @override
  void initState() {
    authController = AuthController(context: context);
    // authController.retCheckVerifyEmail(context);
    startTimer();
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: ColorManager.secondary,),
          onPressed: (){
            Get.offAllNamed(AppRoute.loginRoute);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    AssetsManager.emailSentBlobIMG,
                  ),
                  Lottie.asset(AssetsManager.emailSentIMG),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: ColorManager.white,
                      size: 40.sp,
                    ),
                    const SizedBox(
                      height: AppSize.s12,
                    ),
                    Text(
                      AppString.verifyEmailDescription,
                      style: StylesManager.titleBoldTextStyle(
                        size: 30.sp,
                        color: ColorManager.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    Text(
                      AppString.verifyEmailDescription2,
                      style: StylesManager.titleNormalTextStyle(
                        size: 20.sp,
                        color: ColorManager.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ButtonApp(
                text: isButtonDisabled
                    ? '${getFormattedTime()}'
                    : AppString.resend,
                textColor: isButtonDisabled?ColorManager.secondary:ColorManager.primary,
                backgroundColor: isButtonDisabled?ColorManager.primary:ColorManager.secondary,
                onPressed: isButtonDisabled
                    ? null
                    : () async {
                  await authController.sendEmailVerification(context);
                  startTimer();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

