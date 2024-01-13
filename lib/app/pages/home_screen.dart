import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/app/widgets/drawer_widget.dart';
import 'package:smart_plans/app/widgets/my_plant_item.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../core/utils/app_constant.dart';
import '../../core/utils/color_manager.dart';
import '../widgets/empty_plants_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addPlantRoute);
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
      body: AppConstants.plantsList.isNotEmpty
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
                items: AppConstants.plantsList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return MyPlantItem();
                    },
                  );
                }).toList(),
              ),
            )
          : EmptyPlantsWidget(),
    );
  }
}
