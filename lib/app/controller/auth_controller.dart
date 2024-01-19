import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../core/route/app_route.dart';
import '../models/user_model.dart';
import '../pages/home_screen.dart';
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
    authProvider.user.email = email ?? filed??'';
    authProvider.user.password = password;
    final result = await authProvider.login(context);
    Navigator.of(context).pop();
    if (result['status']) {
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
        typeUser: typeUser,);
    final result = await signUpByUser(context);
    return result;
  }

  signUpByUser(BuildContext context) async {
    Const.loading(context);
    final result = await authProvider.signup(context);
    Navigator.of(context).pop();
    if (result['status']) {
      Get.offNamed(AppRoute.homeRoute);
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
}
