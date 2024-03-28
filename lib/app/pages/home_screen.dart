import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/plant_controller.dart';
import 'package:smart_plans/app/controller/service/fcm_controller.dart';
import 'package:smart_plans/app/controller/utils/firebase.dart';
import 'package:smart_plans/app/models/dummy/plant_dummy.dart';
import 'package:smart_plans/app/pages/notificationa_screen.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import '../models/notification_model.dart';
import '/app/models/planet_model.dart';
import '../../core/route/app_route.dart';
import '../../core/utils/app_constant.dart';
import '../controller/provider/plant_provider.dart';
import '../controller/provider/profile_provider.dart';
import '/app/widgets/add_new_plant.dart';
import '/app/widgets/drawer_widget.dart';
import '/app/widgets/my_plant_item.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/utils/app_string.dart';
import '../widgets/constans.dart';
import '../widgets/empty_plants_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var getPlantsReal;

  DateTime selectDate = DateTime.now();
  late PlantController plantController;

  getPlantsFun() {
    getPlantsReal = FirebaseFun.database
        .child(AppConstants.collectionUser)
        .child(context.read<ProfileProvider>().user.id)
        .onValue;

    return getPlantsReal;
  }

  var getNotifications;
  getNotificationsFun()  {
    String idUser=context.read<ProfileProvider>().user.id;
    getNotifications = FirebaseFirestore.instance.collection(AppConstants.collectionNotification)
        .where('idUser',isEqualTo:idUser).snapshots();
    return getNotifications;
  }

  @override
  void initState() {
    plantController = PlantController(context: context);
    getPlantsFun();
    getNotificationsFun();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () async {
      //
      //       // for(PlanetModel planetModel in PlanetModels.fromJson(plantsDummyJson()).planetModels)
      //       //  await  plantController.planetModelProvider.addDefaultPlanet(context, planetModel: planetModel);
      //
      //        // Get.toNamed(AppRoute.connectionWifiRoute);
      //         Get.toNamed(AppRoute.addPlantRoute);
      //      // FCMService().showLocalNotification(title: 'title', description: 'description');
      //     },
      //     child: Icon(Icons.add),
      //   ),
        // bottomNavigationBar: BottomNavigationBar(
        //   unselectedItemColor: ColorManager.grey,
        //   selectedItemColor: ColorManager.primary,
        //   backgroundColor: ColorManager.secondary,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: InkWell(
        //         onTap: (){
        //           Get.to(()=>NotificationScreen());
        //         },
        //         child: Badge(
        //           child: Icon(Icons.notifications),
        //           label: StreamBuilder<QuerySnapshot>(
        //
        //               stream: getNotifications,
        //               builder: (context, snapshot) {
        //                 if (snapshot.connectionState == ConnectionState.waiting) {
        //                   return   SizedBox.shrink();
        //                 } else if (snapshot.connectionState == ConnectionState.active) {
        //                   if (snapshot.hasError) {
        //                     return   SizedBox.shrink();
        //                   } else if (snapshot.hasData) {
        //
        //                     int countUnRead=0;
        //                     if (snapshot.data!.docs!.length > 0) {
        //                       List<NotificationModel> listNotifications = NotificationModels.fromJson(snapshot.data!.docs!).listNotificationModel;
        //                       for(NotificationModel notificationModel in listNotifications)
        //                         if(!notificationModel.checkRec)
        //                           countUnRead++;
        //
        //                     }
        //                     return
        //                       countUnRead==0?
        //                       SizedBox.shrink()
        //                           :
        //                       Badge(
        //                         backgroundColor: ColorManager.error,
        //                         smallSize: 24.sp,
        //                         largeSize: 30.sp,
        //                         label: Text('${countUnRead}',style: TextStyle(
        //                           color: ColorManager.secondary
        //                         ),),
        //                       );
        //                   } else {
        //                     return   SizedBox.shrink();
        //                   }
        //                 } else {
        //                   return   SizedBox.shrink();
        //                 }
        //               }),
        //         ),
        //       ),
        //       label: '',
        //     ),
        //
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.add),
        //       label: '',
        //     ),
        //   ],
        // ),
        appBar: AppBar(
          title: Text(AppString.appName),
          centerTitle: false,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.settings_outlined,
                size: 40.sp,
              ),
            );
          }),
          actions: [
            IconButton(onPressed: (){
              Get.to(()=>NotificationScreen());
            },
                icon: Badge(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.notifications),
              label: StreamBuilder<QuerySnapshot>(

                  stream: getNotifications,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return   SizedBox.shrink();
                    } else if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasError) {
                        return   SizedBox.shrink();
                      } else if (snapshot.hasData) {

                        int countUnRead=0;
                        if (snapshot.data!.docs!.length > 0) {
                          List<NotificationModel> listNotifications = NotificationModels.fromJson(snapshot.data!.docs!).listNotificationModel;
                          for(NotificationModel notificationModel in listNotifications)
                            if(!notificationModel.checkRec)
                              countUnRead++;

                        }
                        return
                          countUnRead==0?
                          SizedBox.shrink()
                              :
                          Badge(
                            backgroundColor: ColorManager.error,
                            smallSize: 24.sp,
                            largeSize: 30.sp,
                            label: Text('${countUnRead}',style: TextStyle(
                                color: ColorManager.secondary
                            ),),
                          );
                      } else {
                        return   SizedBox.shrink();
                      }
                    } else {
                      return   SizedBox.shrink();
                    }
                  }),
            )),

            IconButton(
                onPressed: () {
                  Get.toNamed(AppRoute.addPlantRoute);
                },
                icon: Icon(
                  Icons.add,
                )),
          ],
        ),
        drawer: DrawerWidget(),
        body: StreamBuilder<DatabaseEvent>(
            stream: getPlantsReal,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Const.SHOWLOADINGINDECATOR();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  Const.SHOWLOADINGINDECATOR();
                  List<PlanetModel> plants = [];
                  if ((snapshot.data?.snapshot.children.length ?? 0) > 0) {
                    plants = PlanetModels.fromJsonReal(
                            snapshot.data!.snapshot.children)
                        .planetModels;
                    plantController.processPlants(context, plants: plants);
                  } else
                    plantController
                        .planetModelProvider.planetModels.planetModels
                        .clear();

                  return ChangeNotifierProvider<PlanetModelProvider>.value(
                      value: Provider.of<PlanetModelProvider>(context),
                      child: Consumer<PlanetModelProvider>(
                          builder: (context, planetModelProvider, child) =>
                              plants.isNotEmpty
                                  ? Center(
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          scrollDirection: Axis.vertical,
                                          height: getHeight(context),
                                          viewportFraction: .5,
                                          enableInfiniteScroll: false,
                                          reverse: false,
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          enlargeFactor: 0.15,
                                        ),
                                        items: plants.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return MyPlantItem(
                                                planetModel: i,
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                      //  ): (listPlant.listTemp.isNotEmpty)
                                    )
                                  : (planetModelProvider.planetModelsApi
                                          .planetModels.isNotEmpty)
                                      ? AddNewPlant()
                                      : EmptyPlantsWidget()));
                  ;
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }));
  }
}
