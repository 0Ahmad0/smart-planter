import 'package:smart_plans/app/models/plant_model.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';

class AppConstants {
  static int splashDelay = 3;

  static double designWidth = 430.0;
  static double designHeight = 932.0;

  static final List<String> plantsList = ['1','2','3','4','5'];
  static final List<PlantModel> plantsDetailsList = [
    PlantModel(text: 'Fertilize', image: AssetsManager.seedBagIMG, screenNamedNavigator: 'screenNamedNavigator'),
    PlantModel(text: 'Water', image: AssetsManager.waterDropIMG, screenNamedNavigator: 'screenNamedNavigator'),
    PlantModel(text: 'Monitor', image: AssetsManager.cameraIMG, screenNamedNavigator: 'screenNamedNavigator'),
  ];

}