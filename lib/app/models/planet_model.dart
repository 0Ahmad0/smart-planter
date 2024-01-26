//UserModel
import 'package:cloud_firestore/cloud_firestore.dart';

class PlanetModel {
  int?  plantId;
  String id;
  String userId;
  String? common_name;
  String? urlIMG;
  num? days_to_harvest;
  String? description;
  num? ph_maximum;
  num? ph_minimum;
  num? light;
  num? minimum_temperature;
  num? maximum_temperature;
  num? soil_nutriments;
  num? soil_humidity;

  PlanetModel({
    required this.id,
    required this.plantId,
    required this.common_name,
    required this.urlIMG,
    required this.days_to_harvest,
    required this.description,
    required this.ph_maximum,
    required this.ph_minimum,
    required this.light,
    required this.minimum_temperature,
    required this.maximum_temperature,
    required this.soil_nutriments,
    required this.soil_humidity,
    required this.userId,
  });

  factory PlanetModel.fromJson(json) {
;
    return PlanetModel(
      id: json['id'],
      plantId : json["plantId"],
      userId : json["userId"],
    common_name : json["common_name"],
    urlIMG: json["urlIMG"],
    days_to_harvest: json["days_to_harvest"],
    description: json["description"],
    ph_maximum : json["ph_maximum"],
    ph_minimum: json["ph_minimum"],
    light : json["light"],
    minimum_temperature: json["minimum_temperature"],
    maximum_temperature: json["maximum_temperature"],
    soil_nutriments: json["soil_nutriments"],
      soil_humidity: json["soil_humidity"],
    );
  }
  factory PlanetModel.init(){
    return PlanetModel(id: '', common_name: '', urlIMG: null, days_to_harvest: 0, description: '', ph_maximum: 0, ph_minimum: 0, light: 0, minimum_temperature: 0, maximum_temperature: 0, soil_nutriments: 0, soil_humidity: 0, plantId: 0, userId: '');
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'plantId': plantId,
    'userId': userId,
    'common_name': common_name,
    'urlIMG': urlIMG,
    'days_to_harvest': days_to_harvest,
    'description': description,
    'ph_maximum': ph_maximum,
    'ph_minimum': ph_minimum,
    'light': light,
    'minimum_temperature': minimum_temperature,
    'maximum_temperature': maximum_temperature,
    'soil_nutriments': soil_nutriments,
    'soil_humidity': soil_humidity,
  };
}
//PlanetModels
class PlanetModels {
  List<PlanetModel> planetModels;

  //DateTime date;

  PlanetModels({required this.planetModels});

  factory PlanetModels.fromJson(json) {
    List<PlanetModel> tempModels = [];

    for (int i = 0; i < json.length; i++) {
      PlanetModel tempUserModel = PlanetModel.fromJson(json[i]);
      tempUserModel.id = json[i].id;
      tempModels.add(tempUserModel);
    }
    return PlanetModels(planetModels: tempModels);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUserModels = [];
    for (PlanetModel planetModel in planetModels) {
      tempUserModels.add(planetModel.toJson());
    }
    return {
      'planetModels': tempUserModels,
    };
  }


}
