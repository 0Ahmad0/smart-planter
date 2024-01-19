//Notification
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String idNotification;
  String idUser;
  DateTime dateTime;
  String subtitle;
  String title;
  String message;
  bool checkSend;
  bool checkRec;
  NotificationModel({
    this.id="",
    this.idNotification='',
    required this.idUser,
    required this.subtitle,
    required this.dateTime,
    required this.title,
    required this.message,
    this.checkSend=false,
    this.checkRec=false,
  });

  factory NotificationModel.fromJson(json) {
    return NotificationModel(
      id: json['id'],
      idNotification: json['idNotification'],
      idUser: json['idUser'],
      subtitle: json['subtitle'],
      title: json['title'],
      message: json['message'],
      checkSend: json['checkSend'],
      checkRec: json['checkRec'],
      dateTime: json['dateTime'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idNotification': idNotification,
      'idUser': idUser,
      'subtitle': subtitle,
      'title': title,
      'message': message,
      'checkSend': checkSend,
      'checkRec': checkRec,
      'dateTime': Timestamp.fromDate(dateTime),
    };
  }
  factory NotificationModel.init(){
    return NotificationModel(idUser: '', subtitle: '', dateTime: DateTime.now(), title: '', message: '');
  }
}

//NotificationModels
class NotificationModels {

  List<NotificationModel> listNotificationModel;


  NotificationModels({
    required this.listNotificationModel});

  factory NotificationModels.fromJson(json) {
    List<NotificationModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      NotificationModel tempElement = NotificationModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return NotificationModels(
        listNotificationModel: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listNotificationModel) {
      temp.add(element.toJson());
    }
    return {
      'listNotificationModel': temp,
    };
  }
  factory NotificationModels.init()=>NotificationModels(listNotificationModel: []);
}