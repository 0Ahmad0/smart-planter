
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_plans/app/domain/services/api_services_imp.dart';
import '../../models/planet_model.dart';
import '../../widgets/constans.dart';
import '../utils/firebase.dart';

class PlanetModelProvider with ChangeNotifier {
  PlanetModel planetModel = PlanetModel.init();
  PlanetModels planetModels = PlanetModels(planetModels: []);
  PlanetModels planetModelsApi = PlanetModels(planetModels: []);
  var arguments = {};

  fetchAllPlanetModelFromApi(BuildContext context) async {
    var result;
    result = await ApiServicesImp(Dio()).get('/plants');
    if (result['status']) {
      planetModelsApi = PlanetModels.fromJson(result['data']);
      print(planetModelsApi.planetModels.length);
    }
    return result;
  }

  fetchAllPlanetModel(BuildContext context) async {
    var result;
    result = await FirebaseFun.fetchAllPlanetModel();
    if (result['status']) {
      planetModels = PlanetModels.fromJson(result['body']);
    }
    return result;
  }


  fetchPlanetModelsByUserID(BuildContext context,
      {required String userId}) async {
    var result;
    result = await FirebaseFun.fetchPlanetModelsByUserID(userId);
    if (result['status']) {
      planetModels = PlanetModels.fromJson(result['body']);
    }
    return result;
  }

  addPlanetModel(BuildContext context,
      {required PlanetModel planetModel}) async {
    var result;
    result = await FirebaseFun.addPlanetModel(planetModel: planetModel);
    return result;
  }

  updatePlanetModel(BuildContext context,
      {required PlanetModel planetModel}) async {
    var result;

    result = await FirebaseFun.updatePlanetModel(planetModel: planetModel);
    return result;
  }

  updateLocalPlant(
      {required PlanetModel planetModel}) async {
    this.planetModel=planetModel;
    Timer(Duration(seconds: 1), () {  notifyListeners();});

  }

  deletePlanetModel(BuildContext context, {required PlanetModel planetModel}) async {
    var result;
    result = await FirebaseFun.deletePlanetModel(planetModel: planetModel);
    if(context.mounted)
    Const.TOAST(context, textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
}
