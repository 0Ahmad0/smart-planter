import 'package:smart_plans/app/pages/add_plant_screen.dart';
import 'package:smart_plans/app/pages/details/details_screen.dart';
import 'package:smart_plans/app/pages/details/monitor_details_screen.dart';

import '../../app/pages/forget_passord_screen.dart';
import '../../app/pages/home_screen.dart';
import '../../app/pages/signup_screen.dart';
import '../../app/pages/login_screen.dart';
import '../../app/pages/splash_screen.dart';

class AppRoute {
  ///<Screens Names>///
  static const initialRoute = '/';
  static const loginRoute = '/login';
  static const signupRoute = '/signup';
  static const forgetPasswordRoute = '/forgetPassword';
  static const homeRoute = '/home';
  static const addPlantRoute = '/addPlant';
  static const detailsRoute = '/details';
  static const monitorDetailsRoute = '/monitorDetails';

  ///<Screens Widgets>///

  static final routesMap = {
    initialRoute: (context) => SplashScreen(),
    loginRoute: (context) => LoginScreen(),
    signupRoute: (context) => SignupScreen(),
    forgetPasswordRoute: (context) => ForgetPasswordScreen(),
    homeRoute: (context) => HomeScreen(),
    addPlantRoute: (context) => AddPlantScreen(),
    detailsRoute: (context) => DetailsScreen(),
    monitorDetailsRoute: (context) => MonitorDetailsScreen(),
  };
}
