import 'package:flutter/material.dart';

import '/app/models/plant_model.dart';
import '/core/utils/assets_manager.dart';

class AppConstants {
  static int splashDelay = 3;

  static double designWidth = 430.0;
  static double designHeight = 932.0;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final List<String> plantsList = [];
  static final List<PlantModel> plantsDetailsList = [
    PlantModel(text: 'Fertilize', image: AssetsManager.seedBagIMG),
    PlantModel(text: 'Water', image: AssetsManager.waterDropIMG),
    PlantModel(text: 'Monitor', image: AssetsManager.cameraIMG),
  ];

  //local storage
  static const rememberMe = "rememberMe";
  static const tokenKEY = "token";
  static const idKEY = "id";
  static const uidKEY = "uid";

  //collection
  static String collection = "";
  static String collectionUser = "User";
  static String collectionNotification = "Notification";
  static String collectionPlant = "Plant";
}
