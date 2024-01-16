import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/route/app_route.dart';
import '../../core/utils/app_string.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import '../widgets/button_app.dart';
import '../widgets/textfield_app.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.resetPassword),
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
                      AppString.emailRecoveryDescription,
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
                  height: AppSize.s30,
                ),
                Form(
                  key: _formKey,
                  child: TextFiledApp(
                    controller: emailController,
                    iconData: Icons.alternate_email,
                    hintText: AppString.emailRecovery,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                ButtonApp(
                  text: AppString.send,
                  textColor: ColorManager.primary,
                  backgroundColor: ColorManager.secondary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Send Email ');
                    } else {
                      print('Error');
                    }
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
