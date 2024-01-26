

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
    int?  plantId,
    String? common_name,
    String? urlIMG,
    num? days_to_harvest,
    String? description,
    num? ph_maximum,
    num? ph_minimum,
    num? light,
    num? minimum_temperature,
    num? maximum_temperature,
    num? soil_nutriments,
    num? soil_humidity,
  }) async {
    ProfileProvider profileProvider= Provider.of<ProfileProvider>(context,listen: false);
    Const.loading(context);
    var result;
       result=await planetModelProvider.addPlanetModel(context, planetModel:
       PlanetModel(
           id: '',
           plantId: plantId,
           common_name: common_name,
           urlIMG: urlIMG,
           days_to_harvest: days_to_harvest,
           description: description,
           ph_maximum: ph_maximum,
           ph_minimum: ph_minimum,
           light: light,
           minimum_temperature: minimum_temperature,
           maximum_temperature: maximum_temperature,
           soil_nutriments: soil_nutriments,
           soil_humidity: soil_humidity,
           userId: profileProvider.user.id)
       );
       if(result['status']){
         Navigator.of(context).pop();
         Get.offAllNamed(AppRoute.homeRoute);
       }
       Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    Navigator.of(context).pop();
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

}