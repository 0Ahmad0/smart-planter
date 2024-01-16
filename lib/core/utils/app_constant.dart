import 'package:smart_plans/app/models/plant_model.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';

class AppConstants {
  static int splashDelay = 3;

  static double designWidth = 430.0;
  static double designHeight = 932.0;

  static final List<String> plantsList = [];
  static final List<PlantModel> plantsDetailsList = [
    PlantModel(text: 'Fertilize', image: AssetsManager.seedBagIMG),
    PlantModel(text: 'Water', image: AssetsManager.waterDropIMG),
    PlantModel(text: 'Monitor', image: AssetsManager.cameraIMG),
  ];

}