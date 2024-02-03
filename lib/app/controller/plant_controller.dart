

import 'dart:io';
import 'dart:math';
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/provider/plant_provider.dart';
import 'package:smart_plans/app/controller/provider/profile_provider.dart';
import 'package:smart_plans/app/controller/utils/firebase.dart';
import 'package:smart_plans/app/domain/services/api_service.dart';
import 'package:smart_plans/app/domain/services/api_services_imp.dart';
import 'package:smart_plans/app/models/planet_model.dart';


import '../../../core/utils/app_constant.dart';
import '../../../core/utils/color_manager.dart';
import '../../core/route/app_route.dart';
import '../widgets/constans.dart';


class PlantController{
  late PlanetModelProvider planetModelProvider;

  var context;
  PlantController({required this.context}){

    planetModelProvider= Provider.of<PlanetModelProvider>(context,listen: false);
  }

  addPlant(context,  {
    required PlanetModel planetModel
  }) async {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    planetModel.userId=profileProvider.user.id;
    Const.loading(context);
    var result;
       result=await planetModelProvider.addPlanetModel(context, planetModel:
       planetModel
       );
       if(result['status']){
       planetModelProvider.planetModelsApi.planetModels.clear();
       planetModelProvider..notifyListeners();
         Navigator.of(context).pop();
         Get.offAllNamed(AppRoute.homeRoute);
       }
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    Navigator.of(context).pop();
    return result;
  }

  getPlants(context,) async {
    Const.loading(context);
    var result=await planetModelProvider.fetchAllPlanetModelFromApi(context);
    Navigator.of(context).pop();
    if(result['status']){
      Get.offAllNamed(AppRoute.homeRoute);
    }
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }


  updatePlanetModel(context,{ required PlanetModel planetModel}) async {
    Const.loading(context);
    var result=await planetModelProvider.updatePlanetModel(context,planetModel: planetModel);
    Navigator.of(context).pop();
    if(result['status']){
      Navigator.of(context).pop();
    }
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  deletePlanetModel(context,{ required PlanetModel planetModel}) async {
    Const.loading(context);
    await planetModelProvider.deletePlanetModel(context,planetModel: planetModel);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
  List<String> getListRepeat(){
    return[
      "Every day",
      "Every 3 days",
      "Every week",
      "Every 2 week",
      "Every 3 week",
      "Every month",
      "Every 2 month",
      "Every 3 month",
    ];
  }

}