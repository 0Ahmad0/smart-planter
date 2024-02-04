import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main()async{
   await WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetStorage.init();
  Provider.debugCheckInvalidValueType = null;
  runApp(SmartPlantsApp());
}