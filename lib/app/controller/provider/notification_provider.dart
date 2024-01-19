
import 'package:flutter/cupertino.dart';
import '../../models/notification_model.dart';
import '../../widgets/constans.dart';
import '../utils/firebase.dart';


class NotificationProvider extends ChangeNotifier{

  NotificationModel notification= NotificationModel.init();
  NotificationModels notifications=NotificationModels(listNotificationModel: []);

  addNotification(context,{ required NotificationModel notification}) async {
    var result;
    result =await FirebaseFun.addNotification(notification: notification);
    //print(result);
    //   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
       return result;
  }
  updateNotification(context,{ required NotificationModel notification}) async {
    var result;
    result =await FirebaseFun.updateNotification(notification: notification);

    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  deleteNotification(context,{ required NotificationModel notification}) async {
    var result;
    result =await FirebaseFun.deleteNotification(notification: notification);

    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }



}