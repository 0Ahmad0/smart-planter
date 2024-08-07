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
import 'package:smart_plans/app/models/notification_model.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import '/app/controller/provider/plant_provider.dart';
import '/app/controller/provider/profile_provider.dart';
import '/app/controller/utils/firebase.dart';
import '/app/models/planet_model.dart';

import '../../../core/utils/app_constant.dart';
import '../../../core/utils/color_manager.dart';
import '../../core/route/app_route.dart';
import '../widgets/constans.dart';

class PlantController {
  late PlanetModelProvider planetModelProvider;

  var context;

  PlantController({required this.context}) {
    planetModelProvider =
        Provider.of<PlanetModelProvider>(context, listen: false);
  }

  addDefaultPlanet(BuildContext context,
      {required PlanetModel planetModel, XFile? image}) async {
    // if (planetModel.temperature.maximum == null)
    //   planetModel.temperature.maximum = planetModel.temperature.degree;
    // if (planetModel.soil_ph.minimum == null)
    //   planetModel.soil_ph.minimum = planetModel.soil_ph.degree;
    // if (planetModel.soil_moister.minimum == null)
    //   planetModel.soil_moister.minimum = planetModel.soil_moister.degree;
    // if (planetModel.sunlight.minimum == null)
    //   planetModel.sunlight.minimum = planetModel.sunlight.degree;
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    planetModel.userId = profileProvider.user.id;
    planetModel.id = Timestamp.now().seconds;
    Const.loading(context);
    var result;
    result = await planetModelProvider.addDefaultPlanet(context,
        planetModel: planetModel, image: image);
    Navigator.of(context).pop();
    if (result['status']) {
      //    planetModelProvider.planetModelsApi.planetModels.clear();
//      planetModelProvider..notifyListeners();
      Get.offAllNamed(AppRoute.homeRoute);
    }
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  addPlant(BuildContext context, {required PlanetModel planetModel}) async {
    if (planetModel.temperature.degree == null)
      planetModel.temperature.degree = planetModel.temperature.minimum;
    if (planetModel.soil_ph.degree == null)
      planetModel.soil_ph.degree = planetModel.soil_ph.minimum;
    if (planetModel.soil_moister.degree == null)
      planetModel.soil_moister.degree = planetModel.soil_moister.minimum;
    if (planetModel.sunlight.degree == null)
      planetModel.sunlight.degree = planetModel.sunlight.minimum;
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    planetModel.userId = profileProvider.user.id;
    Const.loading(context);
    var result;

    ///real and fire store
    // if (AppConstants.strawberry == planetModel.name || 1 == planetModel.id)
    //   result =
    //   await planetModelProvider.addPlanetModelReal(context, planetModel:
    //   planetModel
    //   );
    // result = result =
    // await planetModelProvider.addPlanetModel(context, planetModel:
    // planetModel
    // );
    result = await planetModelProvider.addPlanetModelReal(context,
        planetModel: planetModel);
    Navigator.of(context).pop();
    if (result['status']) {
      planetModelProvider.planetModelsApi.planetModels.clear();
      planetModelProvider..notifyListeners();
      // NotificationProvider().addNotification(context,
      //     notification: NotificationModel(idUser:context.read<ProfileProvider>().user.id, subtitle:AppString.notify_new_plant_subtitle+ ' ${planetModel.name}', dateTime: DateTime.now(), title:AppString.notify_new_plant_title, message: ''));

      Get.offAllNamed(AppRoute.homeRoute);
    }
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));

    return result;
  }

  getPlants(
    context,
  ) async {
    Const.loading(context);
    var result = await planetModelProvider.fetchAllPlanetModelFromApi(context);
    Navigator.of(context).pop();
    if (result['status']) {
      Get.offAllNamed(AppRoute.homeRoute);
    }
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  changePlantsFromReal(BuildContext context,
      {required PlanetModel newPlanetModel,
      required PlanetModel? oldPlanetModel}) {
    if (oldPlanetModel != null) {
      newPlanetModel.plantId = oldPlanetModel.plantId;
      newPlanetModel.userId = oldPlanetModel.userId;
      newPlanetModel.sunlight = MinMaxModel(
          minimum: oldPlanetModel.sunlight.minimum,
          maximum: oldPlanetModel.sunlight.maximum,
          degree: newPlanetModel.sunlight.degree);
      newPlanetModel.soil_moister = MinMaxModel(
          minimum: oldPlanetModel.soil_moister.minimum,
          maximum: oldPlanetModel.soil_moister.maximum,
          degree: newPlanetModel.soil_moister.degree);
      newPlanetModel.soil_ph = MinMaxModel(
          minimum: oldPlanetModel.soil_ph.minimum,
          maximum: oldPlanetModel.soil_ph.maximum,
          degree: newPlanetModel.soil_ph.degree);
      newPlanetModel.temperature = MinMaxModel(
          minimum: oldPlanetModel.temperature.minimum,
          maximum: oldPlanetModel.temperature.maximum,
          degree: newPlanetModel.temperature.degree);
    }
    return newPlanetModel;
  }

  processPlants(BuildContext context,
      {required List<PlanetModel> plants, bool isGetToProvider = true}) async {
    for (PlanetModel planetModel in plants) {
      PlanetModel? oldPlanetModel = getPlantByIdPlantFromList(
          id: planetModel.id,
          plants: planetModelProvider.planetModels.planetModels);

      ///real and fire store
      // if(AppConstants.strawberry==planetModel.name||1==planetModel.id){
      //      planetModelProvider.updatePlanetModel(context, planetModel:
      //     changePlantsFromReal(context, newPlanetModel: planetModel, oldPlanetModel: oldPlanetModel)
      //     );
      //     await planetModelProvider.updatePlanetModelReal(context, planetModel:
      //     changePlantsFromReal(context, newPlanetModel: planetModel, oldPlanetModel: oldPlanetModel)
      //     );
      // }
      //     await planetModelProvider.updatePlanetModelReal(context, planetModel:
      //     changePlantsFromReal(context, newPlanetModel: planetModel, oldPlanetModel: oldPlanetModel)
      //     );

      addNotifyPlantChanged(context, oldPlanetModel, planetModel);
    }
    if (isGetToProvider) planetModelProvider.planetModels.planetModels = plants;

    //change current plant
    PlanetModel? newPlanetModel = getPlantByIdPlantFromList(
        id: planetModelProvider.planetModel?.id, plants: plants);
    if (newPlanetModel != null) {
      planetModelProvider.updateLocalPlant(planetModel: newPlanetModel);
      ;
      //planetModelProvider.planetModel=newPlanetModel;
      //planetModelProvider..notifyListeners();
    }
  }

  processDefaultPlants(BuildContext context,
      {required List<PlanetModel> plants}) {
    for (PlanetModel planetModel in plants) {
      PlanetModel? oldPlanetModel = getPlantByIdPlantFromList(
          id: planetModel.id,
          plants: planetModelProvider.planetModels.planetModels);
      if (oldPlanetModel != null) planetModel.isAdd = true;
    }
    planetModelProvider.planetModelsApi.planetModels = plants;
    return plants;
  }

  PlanetModel? getPlantByIdFromList(
      {required String? plantId, required List<PlanetModel> plants}) {
    for (PlanetModel planetModel in plants)
      if (planetModel.plantId == plantId) return planetModel;
  }

  PlanetModel? getPlantByIdPlantFromList(
      {required int? id, required List<PlanetModel> plants}) {
    for (PlanetModel planetModel in plants)
      if (planetModel.id == id) return planetModel;
  }

  addNotifyPlantChanged(BuildContext context, PlanetModel? oldPlanetModel,
      PlanetModel planetModel2) {
    String idUser = context.read<ProfileProvider>().user.id;
    if (oldPlanetModel == null)
      ;

    // NotificationProvider().addNotification(context,
    //     notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_new_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_new_plant_title, message: ''));

    // else if(oldPlanetModel!.plantId!=planetModel2.plantId||oldPlanetModel.description!=planetModel2.description)
    //    NotificationProvider().addNotification(context,
    //        notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));

    else if (oldPlanetModel.temperature.minimum !=
            planetModel2.temperature.minimum ||
        oldPlanetModel.temperature.maximum !=
            planetModel2.temperature.maximum ||
        oldPlanetModel.temperature.degree != planetModel2.temperature.degree) {
      if (compareNumber(planetModel2.temperature.degree,
              planetModel2.temperature.maximum ?? 25) ==
          1)
        NotificationProvider().addNotification(context, //temperature
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_max_temperature_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.temperature.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
      else if (compareNumber(planetModel2.temperature.degree,
              planetModel2.temperature.minimum ?? 15) ==
          -1)
        NotificationProvider().addNotification(context, //sunligght
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_min_temperature_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.temperature.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
    } else if (oldPlanetModel.sunlight.minimum !=
            planetModel2.sunlight.minimum ||
        oldPlanetModel.sunlight.maximum != planetModel2.sunlight.maximum ||
        oldPlanetModel.sunlight.degree != planetModel2.sunlight.degree) {
      if (compareNumber(planetModel2.sunlight.degree,
              planetModel2.sunlight.maximum ?? 100) ==
          1)
        NotificationProvider().addNotification(context,
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_max_sunlight_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.sunlight.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
      else if (compareNumber(planetModel2.sunlight.degree,
              planetModel2.sunlight.minimum ?? 90) ==
          -1)
        NotificationProvider().addNotification(context,
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_min_sunlight_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.sunlight.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
    } else if (oldPlanetModel.soil_ph.minimum != planetModel2.soil_ph.minimum ||
        oldPlanetModel.soil_ph.maximum != planetModel2.soil_ph.maximum ||
        oldPlanetModel.soil_ph.degree != planetModel2.soil_ph.degree) {
      if (compareNumber(planetModel2.soil_ph.degree,
              planetModel2.soil_ph.maximum ?? 6.5) ==
          1)
        NotificationProvider().addNotification(context,
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_max_soil_ph_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.soil_ph.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
      else if (compareNumber(planetModel2.soil_ph.degree,
              planetModel2.soil_ph.minimum ?? 5.5) ==
          -1)
        NotificationProvider().addNotification(context,
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_min_soil_ph_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.soil_ph.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
    } else if (oldPlanetModel.soil_moister.minimum !=
            planetModel2.soil_moister.minimum ||
        oldPlanetModel.soil_moister.maximum !=
            planetModel2.soil_moister.maximum ||
        oldPlanetModel.soil_moister.degree !=
            planetModel2.soil_moister.degree) {
      if (compareNumber(planetModel2.soil_moister.degree,
              planetModel2.soil_moister.maximum ?? 60) ==
          1)
        NotificationProvider().addNotification(context,
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_max_soil_moister_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.soil_moister.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
      else if (compareNumber(planetModel2.soil_moister.degree,
              planetModel2.soil_moister.minimum ?? 40) ==
          -1)
        NotificationProvider().addNotification(context,
            notification: NotificationModel(
                idUser: idUser,
                subtitle: AppString.notify_min_soil_moister_plant +
                    ' ${planetModel2.name}  ' +
                    '${planetModel2.soil_moister.degree}',
                dateTime: DateTime.now(),
                title: AppString.notify_change_plant_warning,
                message: ''));
    }

    // else if(oldPlanetModel.water_quantity.type!=planetModel2.water_quantity.type
    //     ||oldPlanetModel.water_quantity.value!=planetModel2.water_quantity.value)
    //   NotificationProvider().addNotification(context,
    //       notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_water_quantity_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));
    //
    //
    // else if(oldPlanetModel.fertilizer_quantity.type!=planetModel2.fertilizer_quantity.type
    //     ||oldPlanetModel.fertilizer_quantity.value!=planetModel2.fertilizer_quantity.value)
    //   NotificationProvider().addNotification(context,
    //       notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_fertilizer_quantity_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));
    //

    // else if(oldPlanetModel.repeat_fertilizing!=planetModel2.repeat_fertilizing
    //     ||oldPlanetModel.repeat_watering!=planetModel2.repeat_watering)
    //   NotificationProvider().addNotification(context,
    //       notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_repeat_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));
  }

  compareNumber(num? number1, num? number2) {
    if ((number1 ?? number2 ?? 0) > (number2 ?? 50))
      return 1;
    else if ((number1 ?? number2 ?? 0) < (number2 ?? 10))
      return -1;
    else
      return 0;
  }

  bool isPlantSimilar(PlanetModel planetModel1, PlanetModel planetModel2) {
    if (planetModel1.plantId != planetModel2.plantId ||
        planetModel1.temperature.minimum != planetModel2.temperature.minimum ||
        planetModel1.temperature.maximum != planetModel2.temperature.maximum ||
        planetModel1.temperature.degree != planetModel2.temperature.degree ||
        planetModel1.sunlight.minimum != planetModel2.sunlight.minimum ||
        planetModel1.sunlight.maximum != planetModel2.sunlight.maximum ||
        planetModel1.sunlight.degree != planetModel2.sunlight.degree ||
        planetModel1.soil_ph.minimum != planetModel2.soil_ph.minimum ||
        planetModel1.soil_ph.maximum != planetModel2.soil_ph.maximum ||
        planetModel1.soil_ph.degree != planetModel2.soil_ph.degree ||
        planetModel1.soil_moister.minimum !=
            planetModel2.soil_moister.minimum ||
        planetModel1.soil_moister.maximum !=
            planetModel2.soil_moister.maximum ||
        planetModel1.soil_moister.degree != planetModel2.soil_moister.degree ||
        planetModel1.water_quantity.type != planetModel2.water_quantity.type ||
        planetModel1.water_quantity.value !=
            planetModel2.water_quantity.value ||
        planetModel1.fertilizer_quantity.type !=
            planetModel2.fertilizer_quantity.type ||
        planetModel1.fertilizer_quantity.value !=
            planetModel2.fertilizer_quantity.value ||
        planetModel1.repeat_fertilizing != planetModel2.repeat_fertilizing ||
        planetModel1.repeat_watering != planetModel2.repeat_watering)
      return false;
    return true;
  }

  updatePlanetModel(BuildContext context,
      {required PlanetModel planetModel}) async {
    Const.loading(context);
    var result;
    if (AppConstants.strawberry == planetModel.name || 1 == planetModel.id)
      result = await planetModelProvider.updatePlanetModelReal(context,
          planetModel: planetModel);
    result = result = await planetModelProvider.updatePlanetModel(context,
        planetModel: planetModel);
    Navigator.of(context).pop();
    if (result['status']) {
      // NotificationProvider().addNotification(context,
      //     notification: NotificationModel(idUser:context.read<ProfileProvider>().user.id, subtitle:AppString.notify_change_plant_subtitle+ ' ${planetModel.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));

      Navigator.of(context).pop();
    }
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  updatePlanetModel2(BuildContext context,
      {required PlanetModel planetModel}) async {
    var result;

    ///real and fire store
    // if(AppConstants.strawberry==planetModel.name||1==planetModel.id)
    //   result=await planetModelProvider.updatePlanetModelReal(context, planetModel:
    //   planetModel
    //   );
    // result=result=await planetModelProvider.updatePlanetModel(context, planetModel:
    // planetModel
    // );
    result = await planetModelProvider.updatePlanetModelReal(context,
        planetModel: planetModel);
    Const.TOAST(context,
        textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

  deletePlanetModel(BuildContext context,
      {required PlanetModel planetModel}) async {
    //Const.loading(context);
    String idUser = context.read<ProfileProvider>().user.id;
    var result;

    ///real and fire store
    // if(AppConstants.strawberry==planetModel.name||1==planetModel.id)
    //   result=await planetModelProvider.deletePlanetModelReal(context, planetModel:
    //   planetModel
    //   );
    // result=await planetModelProvider.deletePlanetModel(context, planetModel:
    // planetModel
    // );
    result = await planetModelProvider.deletePlanetModelReal(context,
        planetModel: planetModel);
    if (result['status']) ;
    // NotificationProvider().addNotification(context,
    //     notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_delete_plant_subtitle+ ' ${planetModel.name}', dateTime: DateTime.now(), title:AppString.notify_delete_plant_title , message: ''));

    //Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  List<int> getListRepeat() {
    return [
      0,
      60,
      60 * 3,
      60 * 24,
      60 * 24 * 3,
      60 * 24 * 7,
      60 * 24 * 14,
      60 * 24 * 21,
      60 * 24 * 30,
      60 * 24 * 30 * 2,
      60 * 24 * 30 * 3,
      60 * 24 * 30 * 12,
    ];
    // return[
    //   "Every day",
    //   "Every 3 days",
    //   "Every week",
    //   "Every 2 week",
    //   "Every 3 week",
    //   "Every month",
    //   "Every 2 month",
    //   "Every 3 month",
    // ];
  }
}

//old codes
// import 'dart:io';
// import 'dart:math';
// import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_plans/app/controller/provider/notification_provider.dart';
// import 'package:smart_plans/app/models/notification_model.dart';
// import 'package:smart_plans/core/utils/app_string.dart';
// import '/app/controller/provider/plant_provider.dart';
// import '/app/controller/provider/profile_provider.dart';
// import '/app/controller/utils/firebase.dart';
// import '/app/models/planet_model.dart';

// import '../../../core/utils/app_constant.dart';
// import '../../../core/utils/color_manager.dart';
// import '../../core/route/app_route.dart';
// import '../widgets/constans.dart';

// class PlantController {
//   late PlanetModelProvider planetModelProvider;

//   var context;

//   PlantController({required this.context}) {
//     planetModelProvider =
//         Provider.of<PlanetModelProvider>(context, listen: false);
//   }

//   addDefaultPlanet(BuildContext context,
//       {required PlanetModel planetModel, XFile? image}) async {
//     // if (planetModel.temperature.maximum == null)
//     //   planetModel.temperature.maximum = planetModel.temperature.degree;
//     // if (planetModel.soil_ph.minimum == null)
//     //   planetModel.soil_ph.minimum = planetModel.soil_ph.degree;
//     // if (planetModel.soil_moister.minimum == null)
//     //   planetModel.soil_moister.minimum = planetModel.soil_moister.degree;
//     // if (planetModel.sunlight.minimum == null)
//     //   planetModel.sunlight.minimum = planetModel.sunlight.degree;
//     ProfileProvider profileProvider =
//     Provider.of<ProfileProvider>(context, listen: false);
//     planetModel.userId = profileProvider.user.id;
//     planetModel.id = Timestamp.now().seconds;
//     Const.loading(context);
//     var result;
//     result = await planetModelProvider.addDefaultPlanet(context,
//         planetModel: planetModel, image: image);
//     Navigator.of(context).pop();
//     if (result['status']) {
//       //    planetModelProvider.planetModelsApi.planetModels.clear();
// //      planetModelProvider..notifyListeners();
//       Get.offAllNamed(AppRoute.homeRoute);
//     }
//     Const.TOAST(context,
//         textToast: FirebaseFun.findTextToast(result['message'].toString()));
//     return result;
//   }

//   addPlant(BuildContext context, {required PlanetModel planetModel}) async {
//     if (planetModel.temperature.degree == null)
//       planetModel.temperature.degree = planetModel.temperature.minimum;
//     if (planetModel.soil_ph.degree == null)
//       planetModel.soil_ph.degree = planetModel.soil_ph.minimum;
//     if (planetModel.soil_moister.degree == null)
//       planetModel.soil_moister.degree = planetModel.soil_moister.minimum;
//     if (planetModel.sunlight.degree == null)
//       planetModel.sunlight.degree = planetModel.sunlight.minimum;
//     ProfileProvider profileProvider =
//     Provider.of<ProfileProvider>(context, listen: false);
//     planetModel.userId = profileProvider.user.id;
//     Const.loading(context);
//     var result;

//     ///real and fire store
//     // if (AppConstants.strawberry == planetModel.name || 1 == planetModel.id)
//     //   result =
//     //   await planetModelProvider.addPlanetModelReal(context, planetModel:
//     //   planetModel
//     //   );
//     // result = result =
//     // await planetModelProvider.addPlanetModel(context, planetModel:
//     // planetModel
//     // );
//     result = await planetModelProvider.addPlanetModelReal(context,
//         planetModel: planetModel);
//     Navigator.of(context).pop();
//     if (result['status']) {
//       planetModelProvider.planetModelsApi.planetModels.clear();
//       planetModelProvider..notifyListeners();
//       // NotificationProvider().addNotification(context,
//       //     notification: NotificationModel(idUser:context.read<ProfileProvider>().user.id, subtitle:AppString.notify_new_plant_subtitle+ ' ${planetModel.name}', dateTime: DateTime.now(), title:AppString.notify_new_plant_title, message: ''));

//       Get.offAllNamed(AppRoute.homeRoute);
//     }
//     Const.TOAST(context,
//         textToast: FirebaseFun.findTextToast(result['message'].toString()));

//     return result;
//   }

//   getPlants(
//       context,
//       ) async {
//     Const.loading(context);
//     var result = await planetModelProvider.fetchAllPlanetModelFromApi(context);
//     Navigator.of(context).pop();
//     if (result['status']) {
//       Get.offAllNamed(AppRoute.homeRoute);
//     }
//     Const.TOAST(context,
//         textToast: FirebaseFun.findTextToast(result['message'].toString()));
//     return result;
//   }

//   changePlantsFromReal(BuildContext context,
//       {required PlanetModel newPlanetModel,
//         required PlanetModel? oldPlanetModel}) {
//     if (oldPlanetModel != null) {
//       newPlanetModel.plantId = oldPlanetModel.plantId;
//       newPlanetModel.userId = oldPlanetModel.userId;
//       newPlanetModel.sunlight = MinMaxModel(
//           minimum: oldPlanetModel.sunlight.minimum,
//           maximum: oldPlanetModel.sunlight.maximum,
//           degree: newPlanetModel.sunlight.degree);
//       newPlanetModel.soil_moister = MinMaxModel(
//           minimum: oldPlanetModel.soil_moister.minimum,
//           maximum: oldPlanetModel.soil_moister.maximum,
//           degree: newPlanetModel.soil_moister.degree);
//       newPlanetModel.soil_ph = MinMaxModel(
//           minimum: oldPlanetModel.soil_ph.minimum,
//           maximum: oldPlanetModel.soil_ph.maximum,
//           degree: newPlanetModel.soil_ph.degree);
//       newPlanetModel.temperature = MinMaxModel(
//           minimum: oldPlanetModel.temperature.minimum,
//           maximum: oldPlanetModel.temperature.maximum,
//           degree: newPlanetModel.temperature.degree);
//     }
//     return newPlanetModel;
//   }

//   processPlants(BuildContext context,
//       {required List<PlanetModel> plants, bool isGetToProvider = true}) async {
//     for (PlanetModel planetModel in plants) {
//       PlanetModel? oldPlanetModel = getPlantByIdPlantFromList(
//           id: planetModel.id,
//           plants: planetModelProvider.planetModels.planetModels);

//       ///real and fire store
//       // if(AppConstants.strawberry==planetModel.name||1==planetModel.id){
//       //      planetModelProvider.updatePlanetModel(context, planetModel:
//       //     changePlantsFromReal(context, newPlanetModel: planetModel, oldPlanetModel: oldPlanetModel)
//       //     );
//       //     await planetModelProvider.updatePlanetModelReal(context, planetModel:
//       //     changePlantsFromReal(context, newPlanetModel: planetModel, oldPlanetModel: oldPlanetModel)
//       //     );
//       // }
//       //     await planetModelProvider.updatePlanetModelReal(context, planetModel:
//       //     changePlantsFromReal(context, newPlanetModel: planetModel, oldPlanetModel: oldPlanetModel)
//       //     );

//       addNotifyPlantChanged(context, oldPlanetModel, planetModel);
//     }
//     if (isGetToProvider) planetModelProvider.planetModels.planetModels = plants;

//     //change current plant
//     PlanetModel? newPlanetModel = getPlantByIdPlantFromList(
//         id: planetModelProvider.planetModel?.id, plants: plants);
//     if (newPlanetModel != null) {
//       planetModelProvider.updateLocalPlant(planetModel: newPlanetModel);
//       ;
//       //planetModelProvider.planetModel=newPlanetModel;
//       //planetModelProvider..notifyListeners();
//     }
//   }

//   processDefaultPlants(BuildContext context,
//       {required List<PlanetModel> plants}) {
//     for (PlanetModel planetModel in plants) {
//       PlanetModel? oldPlanetModel = getPlantByIdPlantFromList(
//           id: planetModel.id,
//           plants: planetModelProvider.planetModels.planetModels);
//       if (oldPlanetModel != null) planetModel.isAdd = true;
//     }
//     planetModelProvider.planetModelsApi.planetModels = plants;
//     return plants;
//   }

//   PlanetModel? getPlantByIdFromList(
//       {required String? plantId, required List<PlanetModel> plants}) {
//     for (PlanetModel planetModel in plants)
//       if (planetModel.plantId == plantId) return planetModel;
//   }

//   PlanetModel? getPlantByIdPlantFromList(
//       {required int? id, required List<PlanetModel> plants}) {
//     for (PlanetModel planetModel in plants)
//       if (planetModel.id == id) return planetModel;
//   }

//   addNotifyPlantChanged(BuildContext context, PlanetModel? oldPlanetModel,
//       PlanetModel planetModel2) {
//     String idUser = context.read<ProfileProvider>().user.id;
//     if (oldPlanetModel == null)
//       ;
//     // NotificationProvider().addNotification(context,
//     //     notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_new_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_new_plant_title, message: ''));

//     // else if(oldPlanetModel!.plantId!=planetModel2.plantId||oldPlanetModel.description!=planetModel2.description)
//     //    NotificationProvider().addNotification(context,
//     //        notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));

//     else if (oldPlanetModel.temperature.minimum !=
//         planetModel2.temperature.minimum ||
//         oldPlanetModel.temperature.maximum !=
//             planetModel2.temperature.maximum ||
//         oldPlanetModel.temperature.degree != planetModel2.temperature.degree) {
//       if (compareNumber(planetModel2.temperature.degree,
//           planetModel2.temperature.maximum) ==
//           1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_max_temperature_plant +
//                     ' ${planetModel2.name}  ' + '${planetModel2.temperature.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//       else if (compareNumber(planetModel2.temperature.degree,
//           planetModel2.temperature.minimum) ==
//           -1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_min_temperature_plant +
//                     ' ${planetModel2.name}  ' + '${planetModel2.temperature.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//     } else if (oldPlanetModel.sunlight.minimum !=
//         planetModel2.sunlight.minimum ||
//         oldPlanetModel.sunlight.maximum != planetModel2.sunlight.maximum ||
//         oldPlanetModel.sunlight.degree != planetModel2.sunlight.degree) {
//       if (compareNumber(
//           planetModel2.sunlight.degree, planetModel2.sunlight.maximum) ==
//           1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_max_sunlight_plant +
//                     ' ${planetModel2.name}  ' +'${planetModel2.sunlight.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//       else if (compareNumber(
//           planetModel2.sunlight.degree, planetModel2.sunlight.minimum) ==
//           -1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_min_sunlight_plant +
//                     ' ${planetModel2.name}  ' + '${planetModel2.sunlight.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//     } else if (oldPlanetModel.soil_ph.minimum != planetModel2.soil_ph.minimum ||
//         oldPlanetModel.soil_ph.maximum != planetModel2.soil_ph.maximum ||
//         oldPlanetModel.soil_ph.degree != planetModel2.soil_ph.degree) {
//       if (compareNumber(
//           planetModel2.soil_ph.degree, planetModel2.soil_ph.maximum) ==
//           1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_max_soil_ph_plant +
//                     ' ${planetModel2.name}  ' +
//                     '${planetModel2.soil_ph.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//       else if (compareNumber(
//           planetModel2.soil_ph.degree, planetModel2.soil_ph.minimum) ==
//           -1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_min_soil_ph_plant +
//                     ' ${planetModel2.name}  '+ '${planetModel2.soil_ph.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//     } else if (oldPlanetModel.soil_moister.minimum !=
//         planetModel2.soil_moister.minimum ||
//         oldPlanetModel.soil_moister.maximum !=
//             planetModel2.soil_moister.maximum ||
//         oldPlanetModel.soil_moister.degree !=
//             planetModel2.soil_moister.degree) {
//       if (compareNumber(planetModel2.soil_moister.degree,
//           planetModel2.soil_moister.maximum) ==
//           1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_max_soil_moister_plant +
//                     ' ${planetModel2.name}  '
//                 +'${planetModel2.soil_moister.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//       else if (compareNumber(planetModel2.soil_moister.degree,
//           planetModel2.soil_moister.minimum) ==
//           -1)
//         NotificationProvider().addNotification(context,
//             notification: NotificationModel(
//                 idUser: idUser,
//                 subtitle: AppString.notify_min_soil_moister_plant +
//                     ' ${planetModel2.name}  '+
//                 '${planetModel2.soil_moister.degree}',
//                 dateTime: DateTime.now(),
//                 title: AppString.notify_change_plant_warning,
//                 message: ''));
//     }

//     // else if(oldPlanetModel.water_quantity.type!=planetModel2.water_quantity.type
//     //     ||oldPlanetModel.water_quantity.value!=planetModel2.water_quantity.value)
//     //   NotificationProvider().addNotification(context,
//     //       notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_water_quantity_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));
//     //
//     //
//     // else if(oldPlanetModel.fertilizer_quantity.type!=planetModel2.fertilizer_quantity.type
//     //     ||oldPlanetModel.fertilizer_quantity.value!=planetModel2.fertilizer_quantity.value)
//     //   NotificationProvider().addNotification(context,
//     //       notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_fertilizer_quantity_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));
//     //

//     // else if(oldPlanetModel.repeat_fertilizing!=planetModel2.repeat_fertilizing
//     //     ||oldPlanetModel.repeat_watering!=planetModel2.repeat_watering)
//     //   NotificationProvider().addNotification(context,
//     //       notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_change_repeat_plant_subtitle+ ' ${planetModel2.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));
//   }

//   compareNumber(num? number1, num? number2) {
//     if ((number1 ?? number2 ?? 0) > (number2 ?? 50))
//       return 1;
//     else if ((number1 ?? number2 ?? 0) < (number2 ?? 10))
//       return -1;
//     else
//       return 0;
//   }

//   bool isPlantSimilar(PlanetModel planetModel1, PlanetModel planetModel2) {
//     if (planetModel1.plantId != planetModel2.plantId ||
//         planetModel1.temperature.minimum != planetModel2.temperature.minimum ||
//         planetModel1.temperature.maximum != planetModel2.temperature.maximum ||
//         planetModel1.temperature.degree != planetModel2.temperature.degree ||
//         planetModel1.sunlight.minimum != planetModel2.sunlight.minimum ||
//         planetModel1.sunlight.maximum != planetModel2.sunlight.maximum ||
//         planetModel1.sunlight.degree != planetModel2.sunlight.degree ||
//         planetModel1.soil_ph.minimum != planetModel2.soil_ph.minimum ||
//         planetModel1.soil_ph.maximum != planetModel2.soil_ph.maximum ||
//         planetModel1.soil_ph.degree != planetModel2.soil_ph.degree ||
//         planetModel1.soil_moister.minimum !=
//             planetModel2.soil_moister.minimum ||
//         planetModel1.soil_moister.maximum !=
//             planetModel2.soil_moister.maximum ||
//         planetModel1.soil_moister.degree != planetModel2.soil_moister.degree ||
//         planetModel1.water_quantity.type != planetModel2.water_quantity.type ||
//         planetModel1.water_quantity.value !=
//             planetModel2.water_quantity.value ||
//         planetModel1.fertilizer_quantity.type !=
//             planetModel2.fertilizer_quantity.type ||
//         planetModel1.fertilizer_quantity.value !=
//             planetModel2.fertilizer_quantity.value ||
//         planetModel1.repeat_fertilizing != planetModel2.repeat_fertilizing ||
//         planetModel1.repeat_watering != planetModel2.repeat_watering)
//       return false;
//     return true;
//   }

//   updatePlanetModel(BuildContext context,
//       {required PlanetModel planetModel}) async {
//     Const.loading(context);
//     var result;
//     if (AppConstants.strawberry == planetModel.name || 1 == planetModel.id)
//       result = await planetModelProvider.updatePlanetModelReal(context,
//           planetModel: planetModel);
//     result = result = await planetModelProvider.updatePlanetModel(context,
//         planetModel: planetModel);
//     Navigator.of(context).pop();
//     if (result['status']) {
//       // NotificationProvider().addNotification(context,
//       //     notification: NotificationModel(idUser:context.read<ProfileProvider>().user.id, subtitle:AppString.notify_change_plant_subtitle+ ' ${planetModel.name}', dateTime: DateTime.now(), title:AppString.notify_change_plant_title , message: ''));

//       Navigator.of(context).pop();
//     }
//     Const.TOAST(context,
//         textToast: FirebaseFun.findTextToast(result['message'].toString()));
//     return result;
//   }

//   updatePlanetModel2(BuildContext context,
//       {required PlanetModel planetModel}) async {
//     var result;

//     ///real and fire store
//     // if(AppConstants.strawberry==planetModel.name||1==planetModel.id)
//     //   result=await planetModelProvider.updatePlanetModelReal(context, planetModel:
//     //   planetModel
//     //   );
//     // result=result=await planetModelProvider.updatePlanetModel(context, planetModel:
//     // planetModel
//     // );
//     result = await planetModelProvider.updatePlanetModelReal(context,
//         planetModel: planetModel);
//     Const.TOAST(context,
//         textToast: FirebaseFun.findTextToast(result['message'].toString()));
//     return result;
//   }

//   deletePlanetModel(BuildContext context,
//       {required PlanetModel planetModel}) async {
//     //Const.loading(context);
//     String idUser = context.read<ProfileProvider>().user.id;
//     var result;

//     ///real and fire store
//     // if(AppConstants.strawberry==planetModel.name||1==planetModel.id)
//     //   result=await planetModelProvider.deletePlanetModelReal(context, planetModel:
//     //   planetModel
//     //   );
//     // result=await planetModelProvider.deletePlanetModel(context, planetModel:
//     // planetModel
//     // );
//     result = await planetModelProvider.deletePlanetModelReal(context,
//         planetModel: planetModel);
//     if (result['status']) ;
//     // NotificationProvider().addNotification(context,
//     //     notification: NotificationModel(idUser:idUser, subtitle:AppString.notify_delete_plant_subtitle+ ' ${planetModel.name}', dateTime: DateTime.now(), title:AppString.notify_delete_plant_title , message: ''));

//     //Navigator.of(context).pop();
//     // Navigator.of(context).pop();
//   }

//   List<int> getListRepeat() {
//     return [
//       0,
//       60,
//       60 * 3,
//       60 * 24,
//       60 * 24 * 3,
//       60 * 24 * 7,
//       60 * 24 * 14,
//       60 * 24 * 21,
//       60 * 24 * 30,
//       60 * 24 * 30 * 2,
//       60 * 24 * 30 * 3,
//       60 * 24 * 30 * 12,
//     ];
//     // return[
//     //   "Every day",
//     //   "Every 3 days",
//     //   "Every week",
//     //   "Every 2 week",
//     //   "Every 3 week",
//     //   "Every month",
//     //   "Every 2 month",
//     //   "Every 3 month",
//     // ];
//   }
// }
