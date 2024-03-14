//Notification
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  int id;
  int dayNumber;
  int? timeAmH;
  int? timeAmM;
  int? timePmM;
  int? timePmH;
  int duration;

  ScheduleModel({
    this.id=0,

     this.timePmM,
     this.timePmH,
     this.timeAmM,
     this.timeAmH,
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
    Map<String,dynamic> map = {};
    for (int i = 0; i < json.length; i++){
      if(json[i].toString().split('')[0]=='t');
      //  map['${json[i].toString().substring(0,1)}']=json[i].toString().substring(2,3)
    }
    for (int i = 0; i < json.length; i++) {
      ScheduleModel tempElement = ScheduleModel.fromJson(json[i].value);
    //  tempElement.id = json[i].id;
      temp.add(tempElement);
    }
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