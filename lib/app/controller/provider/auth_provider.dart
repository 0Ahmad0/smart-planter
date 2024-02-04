import 'package:flutter/cupertino.dart';
import '/app/controller/provider/profile_provider.dart';
import '/app/models/advance_model.dart';
import '../../../../core/utils/app_constant.dart';
import 'package:provider/provider.dart';
import '../../../core/local/storage.dart';
import '../../models/user_model.dart';
import '../../widgets/constans.dart';
import '../utils/firebase.dart';

class AuthProvider with ChangeNotifier {
  var keyForm = GlobalKey<FormState>();

  //String text = AppStringsManager.login_to_complete_book;
  var name = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  String typeUser = AppConstants.collectionUser;
  List<String> listTypeUserWithActive = [];
  UserModel user = UserModel(
      id: "id",
      uid: "uid",
      name: "name",
      email: "email",
      password: "password",
      typeUser: "typeUser");

  signup(context) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    bool checkPhoneOrEmailFound = await FirebaseFun.checkPhoneOrEmailFound(
        email: user.email, phone: '', cardId: '');
    var result;
    if (checkPhoneOrEmailFound) {
      result =
          await FirebaseFun.signup(email: user.email, password: user.password);
      if (result['status']) {
        user.uid = result['body']?.uid;
        result = await FirebaseFun.createUser(user: user);
        if (result['status']) {
          await AppStorage.storageWrite(
              key: AppConstants.rememberMe, value: true);
          await AppStorage.storageWrite(
              key: AppConstants.idKEY, value: user.uid);
          await AppStorage.storageWrite(
              key: AppConstants.uidKEY, value: user.uid);
          await AppStorage.storageWrite(
              key: AppConstants.tokenKEY, value: "resultUser['token']");
          AdvanceModel.rememberMe = true;
          user = UserModel.fromJson(result['body']);
          profileProvider.updateUser(user: UserModel.fromJson(result['body']));
        }
      }
    } else {
      result = await FirebaseFun.errorUser("the email already uses");
    }
    print(result);
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  login(context) async {
    var result = await loginWithPhoneNumber(context);
    if (!result['status']) result = await loginWithEmil(context);
    print(result);
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  loginWithEmil(context) async {
    var resultUser =
        await FirebaseFun.login(email: user.email, password: user.password);
    var result;
    if (resultUser['status']) {
      resultUser = await fetchUser(uid: resultUser['body']?.uid);

      result = await _baseLogin(context, resultUserAfterLog: resultUser);
    } else {
      result = resultUser;
    }
    return result;
  }

  loginWithPhoneNumber(context) async {
    var resultUser = await FirebaseFun.loginWithPhoneNumber(
        phoneNumber: user.email, password: user.password, typeUser: typeUser);
    if (!resultUser["status"])
    //  resultUser =await FirebaseFun.loginWithPhoneNumber(phoneNumber: user.email, password: user.password,typeUser: AppConstants.collectionAdmin);
    if (resultUser['status']) {
      user = UserModel.fromJson(resultUser['body']);
      resultUser = await _baseLogin(context, resultUserAfterLog: resultUser);
    }
    return resultUser;
  }

  _baseLogin(context, {required var resultUserAfterLog}) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    var result = resultUserAfterLog;

    if (result['status']) {
      if (listTypeUserWithActive.contains(result['body']['typeUser']) &&
          !result['body']['active'])
        result = FirebaseFun.errorUser("Account not Active");
      else if (listTypeUserWithActive.contains(result['body']['typeUser']) &&
          result['body']['band'])
        result = FirebaseFun.errorUser("Account Banded");
      else {
        await AppStorage.storageWrite(
            key: AppConstants.rememberMe, value: true);
        AdvanceModel.rememberMe = true;
        user = UserModel.fromJson(result['body']);
        await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.id);
        await AppStorage.storageWrite(
            key: AppConstants.uidKEY, value: user.uid);
        await AppStorage.storageWrite(
            key: AppConstants.rememberMe, value: AdvanceModel.rememberMe);
        await AppStorage.storageWrite(
            key: AppConstants.tokenKEY, value: "resultUser['token']");
        AdvanceModel.token = user.uid;
        AdvanceModel.uid = user.uid;
        email.clear();
        password.clear();
        profileProvider.updateUser(user: UserModel.fromJson(result['body']));
      }
    }
    return result;
  }

  loginUid(String uid) async {
    var result = await fetchUser(uid: uid);
    if (result['status']) {
      await AppStorage.storageWrite(key: AppConstants.rememberMe, value: true);
      AdvanceModel.rememberMe = true;
      user = UserModel.fromJson(result['body']);
      await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
      AdvanceModel.token = user.uid;
      email.clear();
      password.clear();
    }
    print(result);
    return result;
  }

  fetchUser({required String uid}) async {
    //var result= await FirebaseFun.fetchUser(uid: uid, typeUser: typeUser);
    var result = await FirebaseFun.fetchUser(
        uid: uid, typeUser: AppConstants.collectionUser);

    if (result['status'] && result['body'] == null) {
      //  result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionAdmin);
      if (result['status'] && result['body'] == null) {
        result = {
          'status': false,
          'message': "account invalid" //LocaleKeys.toast_account_invalid,
        };
      }
    }
    // }
    return result;
  }

  sendPasswordResetEmail(context, {required String resetEmail}) async {
    var result = await FirebaseFun.sendPasswordResetEmail(email: resetEmail);
    print(result);
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  bool isEmailVerification() {
    return FirebaseFun.auth.currentUser?.emailVerified ?? false;
  }

  sendEmailVerification(
    context,
  ) async {
    var result = await FirebaseFun.sendEmailVerification();
    print(result);
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  recoveryPassword(context, {required UserModel user}) async {
    var result = await FirebaseFun.updatePassword(newPassword: user.password);
    if (result["status"])
      var resultUser = await FirebaseFun.updateUser(user: user);
    print(result);
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  onError(error) {
    print(false);
    print(error);
    return {
      'status': false,
      'message': error,
      //'body':""
    };
  }




}
