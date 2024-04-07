import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
import '../../core/helper/validator.dart';
import '/core/utils/app_constant.dart';
import '../controller/auth_controller.dart';
import '/app/widgets/textfield_app.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/route/app_route.dart';
import '/core/utils/app_string.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/styles_manager.dart';
import '/core/utils/values_manager.dart';

import '../widgets/button_app.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
    nameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      colors: ColorManager.gradientColors,
      child: Scaffold(
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
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppString.welcome + ' ',
                            style: StylesManager.titleBoldTextStyle(
                              size: 30.sp,
                            ),
                          ),
                          TextSpan(
                            text: AppString.appName,
                            style: StylesManager.titleBoldTextStyle(
                              size: 32.sp,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
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
                      validator: (value)=>Validator.validateName(name: nameController.text),
                      controller: nameController,
                      iconData: Icons.person_outline,
                      hintText: AppString.name,
                    ),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    TextFiledApp(
                      validator: (value)=>Validator.validateEmail(email: emailController.text),
                      controller: emailController,
                      iconData: Icons.alternate_email,
                      hintText: AppString.email,
                    ),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    TextFiledApp(
                      validator: (value)=>Validator.validatePassword(password: passwordController.text),
                      controller: passwordController,
                      iconData: Icons.lock_outline,
                      hintText: AppString.passWord,
                      suffixIcon: true,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: AppSize.s30,
                    ),
                    TextFiledApp(
                      validator: (value)=>Validator.validateConfirmPassword(
                        confirmPassword: confirmPasswordController.text,
                        password: passwordController.text
                      ),
                      controller: confirmPasswordController,
                      iconData: Icons.lock_outline,
                      hintText: AppString.confirmPassword,
                      suffixIcon: true,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: AppSize.s40,
                    ),
                    ButtonApp(
                      text: AppString.signup,
                      textColor: ColorManager.primary,
                      backgroundColor: ColorManager.secondary,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                            authController.signUp(context,
                                email: emailController.value.text,
                                password: passwordController.value.text,
                                typeUser: AppConstants.collectionUser,
                                name: nameController.value.text);
                        } else {
                          print('No');
                        }
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offNamed(
                            AppRoute.loginRoute,
                          );
                        },
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: AppString.allReadyHaveAccount,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: ColorManager.secondary.withOpacity(.75),
                              )),
                          TextSpan(
                              text: AppString.login,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorManager.secondary,
                                decoration: TextDecoration.underline,
                              ))
                        ])))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
