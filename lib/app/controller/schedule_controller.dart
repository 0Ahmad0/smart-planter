

import 'dart:io';
import 'dart:math';
import 'dart:ui';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/provider/notification_provider.dart';
import 'package:smart_plans/app/controller/provider/schedule_provider.dart';
import 'package:smart_plans/app/models/dummy/day_dummy.dart';
import 'package:smart_plans/app/models/notification_model.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import '../models/schedule_model.dart';
import '/app/controller/provider/plant_provider.dart';
import '/app/controller/provider/profile_provider.dart';
import '/app/controller/utils/firebase.dart';
import '/app/models/planet_model.dart';


import '../../../core/utils/app_constant.dart';
import '../../../core/utils/color_manager.dart';
import '../../core/route/app_route.dart';
import '../widgets/constans.dart';


class ScheduleController {
  late ScheduleModelProvider scheduleModelProvider;

  var context;

  ScheduleController({required this.context}) {
    scheduleModelProvider =
        Provider.of<ScheduleModelProvider>(context, listen: false);
  }



  addScheduleModel(BuildContext context, {
    required ScheduleModel scheduleModel
  }) async {
    scheduleModel.id=Timestamp.now().seconds;
    scheduleModel.dayName??=DaysDummy()[scheduleModel.dayNumber-1];
    Const.loading(context);
    var result;
    result =
    await scheduleModelProvider.addScheduleReal(context, scheduleModel:
    scheduleModel
    );
    if(scheduleModel.dayName!=null)
      await scheduleModelProvider.updateDayReal(context, days: {scheduleModel.dayName!:true});
    Navigator.of(context).pop();
    if (result['status']) {
      scheduleModelProvider.notifyListeners();
      Get.back();
    }
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  updateScheduleModel(BuildContext context,{ required ScheduleModel scheduleModel}) async {
    var result;
    Const.loading(context);
    result=await scheduleModelProvider.updateScheduleReal(context, scheduleModel:
    scheduleModel
    );
    if(scheduleModel.dayName!=null)
      await scheduleModelProvider.updateDayReal(context, days: {scheduleModel.dayName!:true});
    Get.back();
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  deleteScheduleModel(BuildContext context,{ required ScheduleModel scheduleModel}) async {
    //Const.loading(context);
    var result;

    result=await scheduleModelProvider.deleteScheduleModelReal(context, scheduleModel: scheduleModel);
    if(scheduleModel.dayName!=null)
      await scheduleModelProvider.updateDayReal(context, days: {scheduleModel.dayName!:false});
     if(result['status']);
  }


  addAllDayDefault(BuildContext context, ) async {
   Map<String,bool> days= {};
   DaysDummy().forEach((element) {days[element]=false; });
    Const.loading(context);
    var result;
    result =
    await scheduleModelProvider.addDayReal(context,days:days
    );
    Navigator.of(context).pop();
    if (result['status']) {
      scheduleModelProvider.notifyListeners();
      Get.back();
    }
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }



}