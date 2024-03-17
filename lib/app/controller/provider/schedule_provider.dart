
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/provider/profile_provider.dart';
import 'package:smart_plans/app/domain/services/api_services_imp.dart';
import '../../../core/utils/app_constant.dart';
import '../../models/planet_model.dart';
import '../../models/schedule_model.dart';
import '../../widgets/constans.dart';
import '../utils/firebase.dart';

class ScheduleModelProvider with ChangeNotifier {
  ScheduleModel scheduleModel = ScheduleModel.init();
  ScheduleModels scheduleModels = ScheduleModels(listScheduleModel: []);
  var arguments = {};




  fetchScheduleModelsReal(BuildContext context,
     ) async {
    var result;
    result = await FirebaseFun.fetchAllScheduleReal();
    if (result['status']) {
      scheduleModels = ScheduleModels.fromJson(result['body']);
    }
    return result;
  }

  addScheduleReal(BuildContext context,
      {required ScheduleModel scheduleModel}) async {
    var result;
    result = await FirebaseFun.addScheduleReal(scheduleModel: scheduleModel);
    return result;
  }
  updateScheduleReal(BuildContext context,
      {required ScheduleModel scheduleModel}) async {
    var result;

    result = await FirebaseFun.updateScheduleReal(scheduleModel: scheduleModel);
    return result;
  }
  deleteScheduleModelReal(BuildContext context, {required ScheduleModel scheduleModel}) async {
    var result;
    result = await FirebaseFun.deleteScheduleReal(scheduleModel: scheduleModel);
    if(result['status'])
      scheduleModels.listScheduleModel.removeWhere((element) =>scheduleModel.id==element.id );
    if(context.mounted)
    Const.TOAST(context, textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }


  addDayReal(BuildContext context,
      {required Map<String,bool> days}) async {
    var result;
    result = await FirebaseFun.addDaysReal(day: days);
    return result;
  }
  updateDayReal(BuildContext context,
      {required Map<String,bool> days}) async {
    var result;

    result = await FirebaseFun.updateDaysReal(days: days);
    return result;
  }
}
