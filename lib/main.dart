import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'app/controller/service/fcm_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FCMService().setupFCM();
  GetStorage.init();
  Provider.debugCheckInvalidValueType = null;
  runApp(SmartPlantsApp());
}

