import 'package:get/get.dart';

import '../utils/app_string.dart';

class Validator{
  ///@--Email
  static String? validateEmail({required String email}){
    if(email!.trim().isEmpty){
      return AppString.requiredFiled;
    }
    if(!email.isEmail){
      return AppString.enterValidEmail;
    }
    return null;
  }
  ///@--Name
  static String? validateName({required String name}){
    if(name.trim().isEmpty){
      return AppString.requiredFiled;
    }
    if(name.substring(0,1).isNum){
      return AppString.enterValidName;
    }
    return null;
  }
  ///@--Password
  static String? validatePassword({required String password}){
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp numericRegExp = RegExp(r'[0-9]');
    RegExp specialCharacterRegExp = RegExp(r'[!@#$&*~]');
    if(password.trim().isEmpty){
      return AppString.requiredFiled;
    }
    if(password.trim().length < 8){
      return AppString.enterValidPasswordLength;
    }
    if (!upperCaseRegExp.hasMatch(password)) {
      return AppString.enterValidPasswordUpperCase;
    }

    if (!lowerCaseRegExp.hasMatch(password)) {
      return AppString.enterValidPasswordLowerCase;
    }

    if (!numericRegExp.hasMatch(password)) {
      return AppString.enterValidPasswordNumeric;
    }

    if (!specialCharacterRegExp.hasMatch(password)) {
      return AppString.enterValidPasswordSpecial;
    }

    return null;
  }
  ///@--ConfirmPassword
  static String? validateConfirmPassword({required String password , required String confirmPassword}){
    if(confirmPassword.trim().isEmpty){
      return AppString.requiredFiled;
    }
    if(confirmPassword != password){
      return AppString.enterValidConfirmPassword;
    }
    return null;
  }
  
}