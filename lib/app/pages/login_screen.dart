import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../controller/auth_controller.dart';
import '../widgets/button_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //
  final _formKey = GlobalKey<FormState>();

  late AuthController authController;

  @override
  void initState() {
    authController = AuthController(context: context);
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Text(
                    AppString.appName,
                    style: StylesManager.titleBoldTextStyle(
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Image.asset(
                    AssetsManager.logoIMG,
                    width: getWidth(context) / 2,
                    height: getWidth(context) / 2,
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  TextFiledApp(
                    controller: emailController,
                    iconData: Icons.alternate_email,
                    hintText: AppString.email,
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  TextFiledApp(
                    controller: passwordController,
                    iconData: Icons.lock_outline,
                    hintText: AppString.passWord,
                    suffixIcon: true,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  ButtonApp(
                    text: AppString.login,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.login(
                          context,
                          email:emailController.value.text ,
                          password: passwordController.value.text,
                        );
                      } else {
                        print('No');
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  ButtonApp(
                    text: AppString.signup,
                    textColor: ColorManager.primary,
                    backgroundColor: ColorManager.secondary,
                    onPressed: () {
                      Get.offNamed(
                        AppRoute.signupRoute,
                      );
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRoute.forgetPasswordRoute,
                        );
                      },
                      child: Text(
                        AppString.forgetPassword,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: ColorManager.secondary.withOpacity(.75),
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
