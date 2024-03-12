import '../../app/pages/add_new_plant_screen.dart';
import '../../app/pages/add_schedule_screen.dart';
import '../../app/pages/schedule_screen.dart';
import '/app/pages/add_plant_screen.dart';
import '/app/pages/connection_wifi_screen.dart';
import '/app/pages/details/details_screen.dart';
import '/app/pages/details/monitor_details_screen.dart';
import '/app/pages/notificationa_screen.dart';
import '/app/pages/setting_screen.dart';
import '/app/pages/verify_email_screen.dart';
import '../../app/pages/details/details_screen2.dart';
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
  static const verifyEmail = '/verifyEmail';
  static const homeRoute = '/home';
  static const addPlantRoute = '/addPlant';
  static const detailsRoute = '/details';
  static const details2Route = '/details2';
  static const monitorDetailsRoute = '/monitorDetails';
  static const notificationRoute = '/notifications';
  static const connectionWifiRoute = '/connectionWifi';
  static const settingRoute = '/setting';
  static const addNewPlantRoute = '/addNewPlant';
  static const scheduleRoute = '/schedule';
  static const addScheduleRoute = '/addSchedule';



  ///<Screens Widgets>///

  static final routesMap = {
    initialRoute: (context) => SplashScreen(),
    loginRoute: (context) => LoginScreen(),
    signupRoute: (context) => SignupScreen(),
    forgetPasswordRoute: (context) => ForgetPasswordScreen(),
    verifyEmail: (context) => VerifyEmailScreen(),
    homeRoute: (context) => HomeScreen(),
    addPlantRoute: (context) => AddPlantScreen(),
    detailsRoute: (context) => DetailsScreen(),
    details2Route: (context) => DetailsScreen2(),
    monitorDetailsRoute: (context) => MonitorDetailsScreen(),
    notificationRoute: (context) => NotificationScreen(),
    connectionWifiRoute: (context) => ConnectionWifiScreen(),
    settingRoute: (context) => SettingScreen(),
    addNewPlantRoute: (context) => AddNewPlantScreen(),
    scheduleRoute: (context) => ScheduleScreen(),
    addScheduleRoute: (context) => AddScheduleScreen(),
  };
}
