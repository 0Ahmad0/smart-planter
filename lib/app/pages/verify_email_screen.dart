import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/route/app_route.dart';
import '../../core/utils/app_string.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import '../controller/auth_controller.dart';
import '../widgets/button_app.dart';
import '../widgets/textfield_app.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {


  late AuthController authController;

  @override
  void initState() {
    authController = AuthController(context: context);
    authController.sendEmailVerification(context,);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.verifyEmail),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                      color: ColorManager.secondary,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Icon(Icons.notes_sharp,color: ColorManager.error,),
                    subtitle: Text(
                      AppString.verifyEmailDescription,
                      textAlign: TextAlign.center,
                      style: StylesManager.titleNormalTextStyle(
                        size: 20.sp,
                        color: ColorManager.black
                      )?.copyWith(
                        height: 1.8,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSize.s20,
                ),
                ButtonApp(
                  text: AppString.resend,
                  textColor: ColorManager.primary,
                  backgroundColor: ColorManager.secondary,
                  onPressed: () async {
                      await authController.sendEmailVerification(context);

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
