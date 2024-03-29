import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/utils/firebase.dart';
import 'package:smart_plans/core/utils/app_constant.dart';
import '../../core/local/storage.dart';
import '/app/controller/provider/profile_provider.dart';
import '../../core/route/app_route.dart';
import '../models/user_model.dart';

import '../widgets/constans.dart';
import 'provider/auth_provider.dart';

class AuthController {
  late AuthProvider authProvider;
  var context;

  AuthController({required this.context}) {
    authProvider = Provider.of<AuthProvider>(context,
        listen: false);
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
      if(await isEmailVerification(context));
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
      await sendEmailVerification(context);
      Get.offNamed(AppRoute.verifyEmail);
      // Navigator.of(context).pop();

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

  Future<bool> isEmailVerification(BuildContext context) async {
    bool result = await authProvider.isEmailVerification();

    if (!result)
     Get.offNamed(AppRoute.verifyEmail);
     return result;
  }

  Future _checkVerifyEmail(
      BuildContext context, time) async {

    var response =
    await  FirebaseFun.auth.signInWithCustomToken( (await AppStorage.storageRead(key: AppConstants.tokenKEY))??'').then((value) => value.user).onError((error, stackTrace) => null);
    bool isEmailVerification=authProvider.isEmailVerification();

    if(isEmailVerification){
      time.cancel();
      Get.offNamed(AppRoute.homeRoute);
    }
    else if(response==null){
      // time.cancel();
      // AppStorage.depose();
      // Get.offNamed(AppRoute.loginRoute);
    }
    return response;
  }

  Future<void> retCheckVerifyEmail(
      BuildContext context,
      ) async {
    int retRequestTime = 20; //1 minute
    int countRetRequest = 6;
    int i = 1;
    final Timer timer =
    await Timer.periodic(Duration(seconds: retRequestTime), (time) async {
      if (i > countRetRequest) {
      AppStorage.depose();
      Get.offNamed(AppRoute.loginRoute);
      };
      await _checkVerifyEmail(context, time);
      i++;
    });
    //timer.cancel();

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
