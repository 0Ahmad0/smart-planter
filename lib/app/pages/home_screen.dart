import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/plant_controller.dart';
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
  var getPlants;

  DateTime selectDate=DateTime.now();
  late PlantController plantController;
  getPlantsFun()  {
    getPlants = FirebaseFirestore.instance.collection(AppConstants.collectionPlant)
        .where('userId',isEqualTo: context.read<ProfileProvider>().user.id)
        .snapshots();
    return getPlants;
  }
  @override
  void initState() {
    plantController=PlantController(context: context);
    getPlantsFun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
               Get.toNamed(AppRoute.connectionWifiRoute);
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(AppString.myPlants),
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
          ),
          drawer: DrawerWidget(),
          body:
          StreamBuilder<QuerySnapshot>(
              stream: getPlants,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Const.SHOWLOADINGINDECATOR();
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    Const.SHOWLOADINGINDECATOR();
                    List<PlanetModel> plants=[];
                    if (snapshot.data!.docs!.length > 0) {
                      plants= PlanetModels.fromJson(snapshot.data!.docs!).planetModels;
                      plantController.processPlants(context,plants:plants);
                    }
                    return

                      ChangeNotifierProvider<PlanetModelProvider>.value(
                          value: Provider.of<PlanetModelProvider>(context),
                          child: Consumer<PlanetModelProvider>(
                          builder: (context, planetModelProvider, child) =>
                      plants.isNotEmpty?

                      Center(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: getWidth(context),
                          viewportFraction: .9,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.17,
                        ),
                        items: plants.map((i) {
                          return Builder(
                            builder: (BuildContext context) {

                              return MyPlantItem(planetModel:i ,);
                            },
                          );
                        }).toList(),
                      ),
                  //  ): (listPlant.listTemp.isNotEmpty)
                    ): (planetModelProvider.planetModelsApi.planetModels.isNotEmpty)
                          ? AddNewPlant()
                          : EmptyPlantsWidget()));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              })

        )
    ;
  }
}
