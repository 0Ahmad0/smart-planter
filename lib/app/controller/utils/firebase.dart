import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';


import 'package:path/path.dart';
import 'package:smart_plans/core/utils/app_string.dart';

import '../../../core/utils/app_constant.dart';
import '../../models/notification_model.dart';
import '../../models/user_model.dart';


//import '../../translations/locale_keys.g.dart';

class FirebaseFun{
  static var rest;
  static  FirebaseAuth auth=FirebaseAuth.instance;
  static Duration timeOut =Duration(seconds: 60);

   static signup( {required String email,required String password})  async {
    final result=await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((onValueSignup))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static checkPhoneOrEmailFound( {required String email,required String phone,required String cardId})  async {
    var result=await FirebaseFirestore.instance.collection(AppConstants.collectionUser)
    .where('email',isEqualTo: email).
    get().then((onValueFetchUsers))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    if(result['status']&&result["body"].length<1){
      result=await FirebaseFirestore.instance.collection(AppConstants.collectionUser)
          .where('phoneNumber',isEqualTo: phone).
      get().then((onValueFetchUsers))
          .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
      if(result['status']&&result["body"].length<1){
        result=await FirebaseFirestore.instance.collection(AppConstants.collectionUser)
            .where('cardId',isEqualTo: cardId).
        get().then((onValueFetchUsers))
            .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
        if(result['status']&&result["body"].length<1){
          return true;
        }
      }
    }
    return false;
  }
   static createUser( {required UserModel user}) async {
     final result= await FirebaseFirestore.instance.collection(user.typeUser).add(
       user.toJson()
     ).then((value){
       user.id=value.id;
         return {
           'status':true,
           'message':'Account successfully created',
           'body': {
             'id':value.id
           }
      };
     }).catchError(onError);
     if(result['status'] == true){
       final result2=await updateUser(user: user);
       if(result2['status'] == true){
         return{
         'status':true,
         'message':'Account successfully created',
         'body': user.toJson()
         };
       }else{
         return{
           'status':false,
           'message':"Account Unsuccessfully created"
         };
       }
     }else{
       return result;
     }

   }
   static updateUser( {required UserModel user}) async {
      final result =await FirebaseFirestore.instance.collection(user.typeUser).doc(user.id).update(
         user.toJson()
     ).then(onValueUpdateUser)
         .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
      if(result['status']){
        print(true);
       // print(user.id);
        print("id : ${user.id}");
        return {
          'status':true,
          'message':'User successfully update',
          'body': user.toJson()
        };
      }
      return result;
   }
   static updateUserEmail( {required UserModel user}) async {
      final result =await auth.currentUser?.updateEmail(
         user.email
     ).then(onValueUpdateUser)
         .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
      if(result!['status']){
        return {
          'status':true,
          'message':'User Email successfully update',
          'body': user.toJson()
        };
      }
      return result;
   }
  static login( {required String email,required String password})  async {
    final result=await auth.signInWithEmailAndPassword(
      email: email,///"temp@gmail.com",
      password: password,///"123456"
    ).then((onValuelogin))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut,);
    return result;
  }
  static loginWithPhoneNumber( {required String phoneNumber,required String password, required String typeUser })  async {
    final result=await FirebaseFirestore.instance.collection(typeUser).
    where('phoneNumber',isEqualTo: phoneNumber)
        .where('password',isEqualTo:password ).get().
    then((onValueloginWithphoneNumber))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static loginWithFiled( {required String filed,required String value,required String password, required String typeUser })  async {
    final result=await FirebaseFirestore.instance.collection(typeUser).
    where(filed,isEqualTo: value)
       .
    where('password',isEqualTo:password ).
    get().
    then((onValueloginWithphoneNumber))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }


  static logout()  async {
    final result=await FirebaseAuth.instance.signOut()
        .then((onValuelogout))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUser( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUser))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUserId( {required String id,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('id',isEqualTo: id)
        .get()
        .then((onValueFetchUserId))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
  //  print("${id} ${result}");
    return result;
  }

  static fetchUsers()  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionUser)
        .get()
        .then((onValueFetchUsers))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUsersByTypeUser(String typeUser)  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .get()
        .then((onValueFetchUsers))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUsersByTypeUserAndFieldOrderBy({required String typeUser,required String field,required var value})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
    .where(field,isEqualTo: value)
    .orderBy('dateTime')
        .get()
        .then((onValueFetchUsers))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static sendPasswordResetEmail( {required String email})  async {
    final result=await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,///"temp@gmail.com",
    ).then((onValueSendPasswordResetEmail))
        .catchError(onError);
    return result;
  }
  static sendEmailVerification()  async {
    final result=await auth.currentUser?.sendEmailVerification(
    ).then((onValueSendEmailVerification))
        .catchError(onError);
    return result;
  }

  static updatePassword( {required String newPassword})  async {
    final result=await auth.currentUser?.updatePassword(newPassword)
        .then((onValueUpdatePassword))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);

    return result;
  }


  // ///Medical
  // static addMedical( {required model.Medical medical}) async {
  //   final result= await FirebaseFirestore.instance.collection(AppConstants.collectionMedical).add(
  //       medical.toJson()
  //   ).then(onValueAddMedical).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
  //   return result;
  // }
  // static updateMedical( {required model.Medical medical}) async {
  //   final result= await FirebaseFirestore.instance.collection(AppConstants.collectionMedical).doc(
  //       medical.id
  //   ).update(medical.toJson()).then(onValueUpdateMedical).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
  //   return result;
  // }
  // static deleteMedical( {required model.Medical medical}) async {
  //   final result= await FirebaseFirestore.instance.collection(AppConstants.collectionMedical).doc(
  //       medical.id
  //   ).delete().then(onValueDeleteMedical).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
  //   return result;
  // }
  // static fetchAllMedical()  async {
  //   final result=await FirebaseFirestore.instance.collection(AppConstants.collectionMedical)
  //       .get()
  //       .then((onValueFetchMedicals))
  //       .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
  //   return result;
  // }
  //




  ///Notification
  static addNotification( {required NotificationModel notification}) async {
    final result= await FirebaseFirestore.instance.collection(AppConstants.collectionNotification).add(
        notification.toJson()
    ).then(onValueAddNotification).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static updateNotification( {required NotificationModel notification}) async {
    final result= await FirebaseFirestore.instance.collection(AppConstants.collectionNotification).doc(
        notification.id
    ).update(notification.toJson()).then(onValueUpdateNotification).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static deleteNotification( {required NotificationModel notification}) async {
    final result= await FirebaseFirestore.instance.collection(AppConstants.collectionNotification).doc(
        notification.id
    ).delete().then(onValueDeleteNotification).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchNotificationByFieldOrderBy({required String field,required String value})  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionNotification)
        .where(field,isEqualTo: value)
        .get()
        .then((onValueFetchNotifications))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchNotificationByField({required String field,required String value,String orderBy='dateTime'})  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionNotification)
        .where(field,isEqualTo: value)
        .orderBy(orderBy)
        .get()
        .then((onValueFetchNotifications))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }



  static Future<Map<String,dynamic>>  onError(error) async {
    print(false);
    print(error);
    var errorMessage;
    if (error is FirebaseAuthException) {
      errorMessage = error.message ?? "Firebase Authentication Error";
    }
    else if(error is FirebaseException)
    {
      errorMessage = error.message ?? "Firebase Error";
    }
    else
    {
      errorMessage = error;
    }

    return {
      'status':false,
      'message':errorMessage,
      //'body':""
    };
  }
  static Future<Map<String,dynamic>>  onTimeOut() async {
    print(false);
    return {
      'status':false,
      'message':'time out',
      //'body':""
    };
  }

  static Future<Map<String,dynamic>>  errorUser(String messageError) async {
    print(false);
    print(messageError);
    return {
      'status':false,
      'message':messageError,
      //'body':""
    };
  }

  static Future<Map<String,dynamic>> onValueSignup(value) async{
    print(true);
    print("uid : ${value.user?.uid}");
    return {
      'status':true,
      'message':'Account successfully created',
      'body':value.user
    };
  }
  static Future<Map<String,dynamic>> onValueUpdateUser(value) async{
    return {
      'status':true,
      'message':'Account successfully update',
    //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>>onValueSendPasswordResetEmail(value) async{
    return {
      'status':true,
      'message':'Email successfully send code ',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueSendEmailVerification(value) async{
    return {
      'status':true,
      'message':'Email successfully send verify url ',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValuelogin(value) async{
    //print(true);
   // print(value.user.uid);

    return {
      'status':true,
      'message':'Account successfully logged',
      'body':value.user
    };
  }
  static Future<Map<String,dynamic>> onValueloginWithphoneNumber(value) async{


    if(value.docs.length<1){
      return {
        'status':false,
        'message':'Account not successfully logged',
        'body':{
          'users':value.docs}
      };
    }
    return {
      'status':true,
      'message':'Account successfully logged',
      'body': value.docs[0]}
    ;}
  static Future<Map<String,dynamic>> onValuelogout(value) async{
     print(true);
     print("logout");
    return {
      'status':true,
      'message':'Account successfully logout',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUser(value) async{
   // print(true);
    print('uid ${await (value.docs.length>0)?value.docs[0]['uid']:null}');
    print("user : ${(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserId(value) async{
    //print(true);
    //print(await (value.docs.length>0)?value.docs[0]['uid']:null);
   // print("user : ${(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUsers(value) async{
   // print(true);
    print("Users count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Users successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>>onValueUpdatePassword(value) async{
    return {
      'status':true,
      'message':'Password successfully update',
      'body':{}
    };
  }


  static Future<Map<String,dynamic>>onValueAddMedical(value) async{
    return {
      'status':true,
      'message':'Medical successfully add',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdateMedical(value) async{
    return {
      'status':true,
      'message':'Medical successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteMedical(value) async{
    return {
      'status':true,
      'message':'Medical successfully delete',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchMedicals(value) async{
    // print(true);
    print("Wallets count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Medicals successfully fetch',
      'body':value.docs
    };
  }





  static Future<Map<String,dynamic>>onValueAddNotification(value) async{
    return {
      'status':true,
      'message':'Notification successfully add',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdateNotification(value) async{
    return {
      'status':true,
      'message':'Notification successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteNotification(value) async{
    return {
      'status':true,
      'message':'Notification successfully delete',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchNotifications(value) async{
    // print(true);
    print("Notifications count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Notifications successfully fetch',
      'body':value.docs
    };
  }




  static String findTextToast(String text){
     if(text.contains("Password should be at least 6 characters")){
       return AppString.message_short_password;
       //return tr(LocaleKeys.toast_short_password);
     }else if(text.contains("The email address is already in use by another account")){
      return AppString.message_email_already_use;
       // return tr(LocaleKeys.toast_email_already_use);
     }
     else if(text.contains("Account Unsuccessfully created")){
       return AppString.message_Unsuccessfully_created;
       // return tr(LocaleKeys.toast_Unsuccessfully_created);
     }
     else if(text.contains("Account successfully created")){
       return AppString.message_successfully_created;
        // return tr(LocaleKeys.toast_successfully_created);
     }
     else if(text.contains("The password is invalid or the user does not have a password")){
       return AppString.message_password_invalid;
        // return tr(LocaleKeys.toast_password_invalid);
     }
     else if(text.contains("There is no user record corresponding to this identifier")){
       return AppString.message_email_invalid;
        // return tr(LocaleKeys.toast_email_invalid);
     }
     else if(text.contains("The email address is badly formatted")){
       return AppString.message_email_invalid;
       // return tr(LocaleKeys.toast_email_invalid);
     }
     else if(text.contains("Account successfully logged")){
       return AppString.message_successfully_logged;
         // return tr(LocaleKeys.toast_successfully_logged);
     }
     else if(text.contains("A network error")){
       return AppString.message_network_error;
        // return tr(LocaleKeys.toast_network_error);
     }
     else if(text.contains("An internal error has occurred")){
       return AppString.message_network_error;
       // return tr(LocaleKeys.toast_network_error);
     }else if(text.contains("field does not exist within the DocumentSnapshotPlatform")){
       return AppString.message_Bad_data_fetch;
       // return tr(LocaleKeys.toast_Bad_data_fetch);
     }else if(text.contains("Given String is empty or null")){
       return AppString.message_given_empty;
       // return tr(LocaleKeys.toast_given_empty);
     }
     else if(text.contains("time out")){
       return AppString.message_time_out;
       // return tr(LocaleKeys.toast_time_out);
     }
     else if(text.contains("Account successfully logged")){
       return AppString.message_successfully_logged;
       // return tr(LocaleKeys.toast);
     }
     else if(text.contains("Account not Active")){
       return AppString.message_account_not_active;
       // return tr(LocaleKeys.toast_account_not_active);
     }

     return text;
  }
  static int compareDateWithDateNowToDay({required DateTime dateTime}){
     int year=dateTime.year-DateTime.now().year;
     int month=dateTime.year-DateTime.now().month;
     int day=dateTime.year-DateTime.now().day;
     return (year*365+
            month*30+
            day);
  }

//
//   static Future uploadFile2({required File file, required String folder}) async {
//     try {
//
//       String path = basename(file.path??'');
//       print(file.path);
//
// //FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
//       Reference storage = FirebaseStorage.instance.ref().child("${folder}/${path}");
//       UploadTask storageUploadTask = storage.putFile(file);
//       TaskSnapshot taskSnapshot = await storageUploadTask;
//       String url = await taskSnapshot.ref.getDownloadURL();
//       return url;
//     } catch (ex) {
//       //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
//     }
//   }
}