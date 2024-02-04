//UserModel
import 'package:cloud_firestore/cloud_firestore.dart';

class PlanetModel {
  int id;
  String? plantId;
  String? userId;
  String? name;
  String? url_image;
  String? description;
  String? repeat_fertilizing;
  String? repeat_watering;
  MinMaxModel soil_ph;
  MinMaxModel sunlight;
  MinMaxModel soil_moister;
  MinMaxModel temperature;
  QuantityModel fertilizer_quantity;
  QuantityModel water_quantity;

  PlanetModel({
    required this.id,
    required this.plantId,
    required this.description,
    required this.userId,
    required this.name,
    required this.fertilizer_quantity,
    required this.repeat_fertilizing,
    required this.repeat_watering,
    required this.soil_moister,
    required this.soil_ph,
    required this.sunlight,
    required this.temperature,
    required this.url_image,
    required this.water_quantity,
  });

  factory PlanetModel.fromJson(json) {
    return PlanetModel(
      id: json['id'],
      plantId: json["plantId"],
      userId: json["userId"],
      description: json["description"],
      name: json["name"],
      repeat_fertilizing: json["repeat_fertilizing"],
      repeat_watering: json["repeat_watering"],
      url_image: json["url_image"],
      sunlight: MinMaxModel.fromJson(json["sunlight "] ?? json["sunlight"]),
      soil_ph: MinMaxModel.fromJson(json["soil_ph"]),
      soil_moister: MinMaxModel.fromJson(json["soil_moister"]),
      temperature: MinMaxModel.fromJson(json["temperature"]),
      water_quantity: QuantityModel.fromJson(json["water_quantity"]),
      fertilizer_quantity: QuantityModel.fromJson(json["fertilizer_quantity"]),
    );
  }

  factory PlanetModel.init() {
    return PlanetModel(
        id: 0,
        plantId: '',
        description: '',
        userId: '',
        name: '',
        fertilizer_quantity: QuantityModel.init(),
        repeat_fertilizing: '',
        repeat_watering: '',
        soil_moister: MinMaxModel.init(),
        soil_ph: MinMaxModel.init(),
        sunlight: MinMaxModel.init(),
        temperature: MinMaxModel.init(),
        url_image: '',
        water_quantity: QuantityModel.init());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'plantId': plantId,
        'userId': userId,
        'description': description,
        'url_image': url_image,
        'repeat_watering': repeat_watering,
        'repeat_fertilizing': repeat_fertilizing,
        'name': name,
        'water_quantity': water_quantity.toJson(),
        'fertilizer_quantity': fertilizer_quantity.toJson(),
        'temperature': temperature.toJson(),
        'soil_moister': soil_moister.toJson(),
        'soil_ph': soil_ph.toJson(),
        'sunlight ': sunlight.toJson(),
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
      if (json[i] is Map)
        ;
      else
        tempUserModel.plantId = json[i]?.id;
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

class MinMaxModel {
  num? minimum;
  num? degree;
  num? maximum;

  MinMaxModel({
    required this.minimum,
    required this.maximum,
    required this.degree,
  });

  factory MinMaxModel.fromJson(json) {
    ;
    return MinMaxModel(
      minimum: json['minimum'],
      degree: json['degree'],
      maximum: json["maximum"],
    );
  }

  factory MinMaxModel.init() {
    return MinMaxModel(minimum: 0, maximum: 0, degree: null);
  }

  Map<String, dynamic> toJson() => {
        'minimum': minimum,
        'maximum': maximum,
        'degree': degree,
      };
}

class QuantityModel {
  int? value;
  String? type;

  QuantityModel({
    required this.value,
    required this.type,
  });

  factory QuantityModel.fromJson(json) {
    ;
    return QuantityModel(
      value: json['value'],
      type: json["type"],
    );
  }

  factory QuantityModel.init() {
    return QuantityModel(value: 0, type: '');
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };
}