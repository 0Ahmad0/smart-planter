import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/pages/add_new_plant_screen.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import '../../core/utils/app_constant.dart';
import '../controller/plant_controller.dart';
import '../models/dummy/plant_dummy.dart';
import '../models/planet_model.dart';
import '../widgets/constans.dart';
import '/app/widgets/add_plant_item_list.dart';
import '/core/utils/app_string.dart';
import '/core/utils/values_manager.dart';

import '../controller/provider/plant_provider.dart';
import '../widgets/add_plant_item_grid.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  bool isGrid = false;
  var getPlants;

  DateTime selectDate = DateTime.now();
  late PlantController plantController;

  getPlantsFun() {
    getPlants = FirebaseFirestore.instance
        .collection(AppConstants.collectionDefaultPlanet)
        .snapshots();
    return getPlants;
  }

  @override
  void initState() {
    getPlantsFun();
    plantController = PlantController(context: context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      colors: ColorManager.gradientColors,
      child: Scaffold(
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
              backgroundColor: ColorManager.white,
              onPressed: () {
                Get.to(()=>AddNewPlantScreen(),transition: Transition.zoom);
              },
              child: Image.asset(
                AssetsManager.addNewPlantIconIMG,
                width: 40.w,
                height: 40.w,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.secondary
                  ),
                  child: Icon(
                    Icons.add,
                    size: 24.sp,
                    color: ColorManager.primary,
                  ),
                ))
          ],
        ),
        appBar: AppBar(
          title: Text(AppString.addPlant),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isGrid = !isGrid;
                  });
                },
                icon: Icon(isGrid ? Icons.grid_view_rounded : Icons.menu))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: getPlants,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Const.SHOWLOADINGINDECATOR();
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  Const.SHOWLOADINGINDECATOR();

                  List<PlanetModel> plants = [];
                  if (snapshot.data!.docs!.length > 0) {
                    plants =
                        PlanetModels.fromJson(snapshot.data!.docs!).planetModels;
                    plantController.processDefaultPlants(context, plants: plants);
                  } else {
                    {
                      plants =
                          PlanetModels.fromJson(plantsDummyJson()).planetModels;
                      plantController.processDefaultPlants(context,
                          plants: plants);
                    }
                  }

                  return buildPlants(context);
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
    );
  }

  buildPlants(BuildContext context) => isGrid
      ? GridView.builder(
          itemCount: context
              .read<PlanetModelProvider>()
              .planetModelsApi
              .planetModels
              .length,
          padding: const EdgeInsets.all(AppPadding.p10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSize.s10,
              mainAxisSpacing: AppSize.s10),
          itemBuilder: (context, index) => AddPlantItemGrid(
            planetModel: context
                .read<PlanetModelProvider>()
                .planetModelsApi
                .planetModels[index],
          ),
        )
      : ListView.builder(
          itemCount: context
              .read<PlanetModelProvider>()
              .planetModelsApi
              .planetModels
              .length,
          padding: const EdgeInsets.all(AppPadding.p10),
          itemBuilder: (context, index) => AddPlantItemList(
            planetModel: context
                .read<PlanetModelProvider>()
                .planetModelsApi
                .planetModels[index],
          ),
        );
}
