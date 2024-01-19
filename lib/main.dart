import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main(){
  GetStorage.init();
  Provider.debugCheckInvalidValueType = null;
  runApp(SmartPlantsApp());
}