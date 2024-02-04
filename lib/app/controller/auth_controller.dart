import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:smart_plans/core/utils/app_constant.dart';
import '/app/controller/provider/profile_provider.dart';
import '../../core/route/app_route.dart';
import '../models/user_model.dart';

import '../widgets/constans.dart';
import 'provider/auth_provider.dart';

class AuthController {
  late AuthProvider authProvider;
  var context;

  AuthController({required this.context}) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  login(
    BuildContext context, {
    String? filed,
    String? email,
    required String password,
  }) async {
    Const.loading(context);
    authProvider.user.email = email ?? filed ?? '';
    authProvider.user.password = password;
    final result = await authProvider.login(context);
    Navigator.of(context).pop();
    if (result['status']) {
      isEmailVerification(context);
      Get.offNamed(AppRoute.homeRoute);
    }
  }

  signUp(BuildContext context,
      {required String name,
      required String email,
      required String password,
      required String typeUser}) async {
    authProvider.user = UserModel(
      id: '',
      uid: '',
      name: name,
      email: email,
      password: password,
      typeUser: typeUser,
    );
    final result = await signUpByUser(context);
    return result;
  }

  signUpByUser(BuildContext context) async {
    Const.loading(context);
    final result = await authProvider.signup(context);
    Navigator.of(context).pop();
    if (result['status']) {
      Get.offNamed(AppRoute.verifyEmail);
     await sendEmailVerification(context);
      Navigator.of(context).pop();

    }
    return result;
  }

  sendPasswordResetEmail(BuildContext context, {required String email}) async {
    Const.loading(context);
    final result =
        await authProvider.sendPasswordResetEmail(context, resetEmail: email);
    Navigator.of(context).pop();
    if (result['status']) {
      Navigator.of(context).pop();
    }
  }

  Future<void> isEmailVerification(BuildContext context) async {
    bool result = await authProvider.isEmailVerification();
    if (!result)
    Get.offNamed(AppRoute.verifyEmail);
  }

  sendEmailVerification(BuildContext context,) async {
    Const.loading(context);
    final result = await authProvider.sendEmailVerification(context);
    Navigator.of(context).pop();
  }

  recoveryPassword(context, {required String password}) async {
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (password != profileProvider.user.password) {
      String tempPassword = profileProvider.user.password;
      profileProvider.user.password = password;
      final result = await authProvider.recoveryPassword(context,
          user: profileProvider.user);
      if (result['status'])
        profileProvider.updateUser(user: profileProvider.user);
      else
        profileProvider.user.password = tempPassword;
    }
  }
}
