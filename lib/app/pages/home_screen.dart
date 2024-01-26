import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import '../../core/route/app_route.dart';
import '/app/controller/controller.dart';
import '/app/widgets/add_new_plant.dart';
import '/app/widgets/drawer_widget.dart';
import '/app/widgets/my_plant_item.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/utils/app_string.dart';

import '../widgets/constans.dart';
import '../widgets/empty_plants_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ListController listPlant = Get.put(ListController());
    return Obx(() => Scaffold(
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
          body: listPlant.list.isNotEmpty
              ? Center(
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
                    items: [1].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return MyPlantItem();
                        },
                      );
                    }).toList(),
                  ),
                )
              : (listPlant.listTemp.isNotEmpty)
                  ? AddNewPlant()
                  : EmptyPlantsWidget(),
        ));
  }
}
/*

 */
