

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:smart_plans/app/models/user_model.dart';
import '../../../core/local/storage.dart';
import '../../widgets/constans.dart';
import '../auth_controller.dart';
import '../utils/firebase.dart';


class ProfileProvider with ChangeNotifier{
  var firstName = TextEditingController(text: '');
  var lastName = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var phoneNumber = TextEditingController(text: '');
   var name = TextEditingController(text: '');

  bool nameIgnor = true;
  bool emailIgnor = true;
  UserModel user= UserModel(id: "id",uid: "uid", name: "name", email: "email", password: "password",typeUser: "typeUser");
  updateUser({ required UserModel user}){

    this.user=user;
     name = TextEditingController(text: user.name);
     email = TextEditingController(text: user.email);
    if(name.text=='');
    name.text='${firstName.text} ${lastName.text}';
     notifyListeners();
  }
   editUser(context) async {
     UserModel tempUser= UserModel.fromJson(user.toJson());
     tempUser.email =email.value.text;
     tempUser.name=name.value.text;
     if(name.value.text=='');
     tempUser.name='${firstName.value.text} ${lastName.value.text}';
     var result;
     if(user.email!=tempUser.email){
     result=await FirebaseFun.updateUserEmail(user: tempUser);
     }
     if(result==null||result['status']){
        result =await FirebaseFun.updateUser(user: tempUser);
       if(result['status']){
         updateUser(user:UserModel.fromJson(result['body']));
         notifyListeners();
       }
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     ///For Verify Email
     AuthController(context: context).isEmailVerification(context);
     return result;
   }
   logout(context)async{
     var result =await FirebaseFun.logout();
     if(result['status']){
       user= UserModel(id: "id",uid: "uid", name: "name", email: "email",password: "password",typeUser: "typeUser");
       AppStorage.depose();
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }
   checkMeByIdUSer({required String idUser}){
    return (user.id.contains(idUser))?true:false;
   }

}