//Notification
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ScheduleModel {
  int id;
  int dayNumber;
  int? timeAmH;
  int? timeAmM;
  int? timePmM;
  int? timePmH;
  int duration;
  String? timeAm;
  String? timePm;
  String? dayName;

  ScheduleModel({
    this.id=0,

     this.timePmM,
     this.timePmH,
     this.timeAmM,
     this.timeAmH,
     this.timeAm,
     this.timePm,
     this.dayName,
    required this.dayNumber,
    required this.duration,
  });

  factory ScheduleModel.fromJson(json) {
    return ScheduleModel(
      id: json['id'],
      timePmM: json['timePmM'],
      timePmH: json['timePmH'],
      timeAmH: json['timeAmH'],
      timeAmM: json['timeAmM'],
      dayNumber: json['dayNumber'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
    //  'id': id,
      "t${dayNumber}m1":timeAmH,
      "t${dayNumber}h1":timeAmM,
      "t${dayNumber}h2":timePmH,
      "t${dayNumber}m2":timePmM,
      'duration': duration,
    };
  }
  factory ScheduleModel.init(){
    return ScheduleModel( duration: 0, dayNumber: DateTime.now().weekday);
  }
}

//ScheduleModels
class ScheduleModels {

  List<ScheduleModel> listScheduleModel;


  ScheduleModels({
    required this.listScheduleModel});

  factory ScheduleModels.fromJson(json) {
    List<ScheduleModel> temp = [];
    Map<int, List<DataSnapshot>> map = {};
    int duration=((json as List<DataSnapshot>).singleWhere((element) =>element.key=='duration').value as int?)??0;
    for (int i = 1; i < 8; i++){
      List<DataSnapshot> tempDataSp= (json as List<DataSnapshot>).where((element) => element.key?.contains('t${i}')??false).toList();
      if(tempDataSp.isNotEmpty)
        map[i]=tempDataSp;
    }
    map.forEach((key, value) {
      int dayNumber=key-1;
      int? pmH=value.singleWhere((element) => element.key?.contains('m2')??false).value as int?;
      int? pmM=value.singleWhere((element) => element.key?.contains('h2')??false).value as int?;
      int? amH=value.singleWhere((element) => element.key?.contains('h1')??false).value as int?;
      int? amM=value.singleWhere((element) => element.key?.contains('m1')??false).value as int?;
      String? timePm=pmH!=null?'${pmH}:${pmM??0} PM':null;
      String? timeAm=amH!=null?'${amH}:${amM??0} AM':null;
      String? dayName=[
        'Friday',
        'Monday',
        'Saturday',
        'Sunday',
        'Thursday',
        'Tuesday',
        'Wednesday'
      ][dayNumber];
      temp.add(ScheduleModel(dayNumber: dayNumber, duration: duration
      ,timePmM: pmM,timePmH: pmH,timeAmM: amM,timeAmH: amH
      ,timePm:timePm,timeAm:timeAm,dayName:dayName));
    });

    // for (int i = 0; i < json.length; i++) {
    //   ScheduleModel tempElement = ScheduleModel.fromJson(json[i].value);
    // //  tempElement.id = json[i].id;
    //   temp.add(tempElement);
    // }
    return ScheduleModels(
        listScheduleModel: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listScheduleModel) {
      temp.add(element.toJson());
    }
    return {
      'listScheduleModel': temp,
    };
  }
  factory ScheduleModels.init()=>ScheduleModels(listScheduleModel: []);
}