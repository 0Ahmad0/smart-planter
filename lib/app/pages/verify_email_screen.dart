import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_plans/app/controller/profile_controller.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';

import '../../core/utils/app_string.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import '../controller/auth_controller.dart';
import '../widgets/button_app.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late AuthController authController;
  late ProfileController profileController;

  @override
  void initState() {
    authController = AuthController(context: context);
    profileController = ProfileController(context: context);
    authController.sendEmailVerification(
      context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(AssetsManager.emailSentBlobIMG,),
                Lottie.asset(AssetsManager.emailSentIMG),
              ],
            ),
            const Spacer(),
            Text(AppString.verifyEmailDescription,style: StylesManager.titleBoldTextStyle(
              size: 24.sp
            ),textAlign: TextAlign.center,),
            const SizedBox(height: AppSize.s12,),
            Text(AppString.verifyEmailDescription2,style: StylesManager.titleNormalTextStyle(
                size: 20.sp
            ),textAlign: TextAlign.center,),
            InkWell(
              onTap:(){
                authController.sendEmailVerification(
                  context,
                );
              },
              child: Text(AppString.resend,style: StylesManager.titleNormalTextStyle(
                  size: 22.sp,color: Colors.blue
              ),textAlign: TextAlign.center,),
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
