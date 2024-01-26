import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/app_constant.dart';
import '../../models/planet_model.dart';
import '../../widgets/constans.dart';
import '../utils/firebase.dart';


class PlanetModelProvider with ChangeNotifier{
  PlanetModel planetModel=PlanetModel.init();
  PlanetModels planetModels=PlanetModels(planetModels: []);


 fetchAllPlanetModel(BuildContext context) async {
   var result;
     result= await FirebaseFun.fetchAllPlanetModel();
     if(result['status']){
       planetModels=PlanetModels.fromJson(result['body']);
     }
   return result;

 }
  fetchPlanetModelsByUserID(BuildContext context, {required String userId}) async {
    var result;
    result= await FirebaseFun.fetchPlanetModelsByUserID(userId);
    if(result['status']){
      planetModels=PlanetModels.fromJson(result['body']);
    }
    return result;

  }

  addPlanetModel(BuildContext context,{required PlanetModel planetModel}) async {
   var result;
   result=await FirebaseFun.addPlanetModel(planetModel: planetModel);
 return result;
 }
 updatePlanetModel(BuildContext context,{required PlanetModel planetModel}) async {
   var result;

     result=await FirebaseFun.updatePlanetModel(planetModel: planetModel);
   return result;

 }
  deletePlanetModel(context,{ required PlanetModel planetModel}) async {
    var result;
    result =await FirebaseFun.deletePlanetModel(planetModel: planetModel);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
}
