import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/core/route/app_route.dart';
import '/app/controller/auth_controller.dart';
import '/app/controller/provider/auth_provider.dart';
import '/app/controller/provider/profile_provider.dart';
import '../../core/local/storage.dart';
import '../models/advance_model.dart';
import '../models/user_model.dart';
import '../pages/home_screen.dart';
import '../pages/login_screen.dart';

class SplashController {

  initUser(BuildContext context) async {
    await AppStorage.init(null);
    if (AdvanceModel.rememberMe && AdvanceModel.token != "") {

    }
  }

  init(BuildContext context) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await AppStorage.init(context);

    ///TODO language
    // context.locale =(Locale(Advance.language));

    ///end
    if (AdvanceModel.rememberMe && AdvanceModel.token != "") {
      final result = await authProvider.fetchUser(uid: AdvanceModel.uid);
      if (result['status']) {
        if (authProvider.listTypeUserWithActive
                .contains(result['body']['typeUser']) &&
            (!result['body']['active'] || result['body']['band'])) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => const LoginScreen(),
            ),
          );
        } else {
          profileProvider.updateUser(user: UserModel.fromJson(result['body']));

          ///For verify Email
          bool isEmailVerification =await AuthController(context: context).isEmailVerification(context);
          if(isEmailVerification)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );
    }
  }
}
