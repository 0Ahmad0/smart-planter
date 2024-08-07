import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/pages/details/monitor_details_screen.dart';
import 'package:smart_plans/app/pages/details/new_monitor_details_screen.dart';
import 'package:smart_plans/app/widgets/constans.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import '../controller/plant_controller.dart';
import '/app/models/planet_model.dart';
import '/app/widgets/details_plant_widget.dart';
import '/core/route/app_route.dart';
import '/core/utils/app_constant.dart';

import '../../core/helper/sizer_media_query.dart';
import '../../core/utils/color_manager.dart';
import '../controller/provider/plant_provider.dart';

class MyPlantItem extends StatelessWidget {
  MyPlantItem({super.key, required this.planetModel});

  PlanetModel planetModel;

  String dateUserPicker = 'Select Date';

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: getWidth(context),
      margin: EdgeInsets.symmetric(horizontal: AppMargin.m14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(.3),
            blurRadius: 24,
          )
        ],
        borderRadius: BorderRadius.circular(
          24.r,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            //ToDo: look to the mainAxisSize and mainAxisAlignment
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    planetModel.url_image != null
                        ? Image.network(
                            planetModel.url_image!,
                            width: getWidth(context),
                            height: getWidth(context),
                          )
                        : Image.asset(
                            'assets/images/logo.png',
                            width: getWidth(context),
                            height: getWidth(context),
                          ),
                    Positioned(
                      bottom: 0.0,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: AppConstants.plantsDetailsList
                              .map(
                                (e) => DetailsPlantWidget(
                                  onTap: () {
                                    context
                                        .read<PlanetModelProvider>()
                                        .planetModel = planetModel;
                                    print(e.text);
                                    if (e.text == 'Fertilize') {
                                      context
                                          .read<PlanetModelProvider>()
                                          .arguments = {
                                        'text': e.text,
                                        'details': {
                                          'pump': 'Mineral', //'e.pumb',
                                          'quantity': 'Fertilize Quantity',
                                          'soil': 'Optimal Ph',
                                          'repeat': 'Repeat',
                                        }
                                      };
                                      Get.toNamed(
                                        AppRoute.details2Route,
                                        arguments: context
                                            .read<PlanetModelProvider>()
                                            .arguments,
                                      );
                                    }
                                    else if (e.text == 'Monitor') {
                                      Get.to(() => NewMonitorDetailsScreen(),
                                          transition: Transition.rightToLeft);
                                    }
                                    else if (e.text == 'Water') {
                                      context
                                          .read<PlanetModelProvider>()
                                          .arguments = {
                                        'text': e.text,
                                        'details': {
                                          'pump': 'Water', //'e.pumb',
                                          'quantity': 'Water Quantity',
                                          'soil': 'Soil Moisture',
                                          'repeat': 'Repeat',
                                        },
                                      };
                                      Get.toNamed(
                                        AppRoute.detailsRoute,
                                        arguments: context
                                            .read<PlanetModelProvider>()
                                            .arguments,
                                      );
                                    } else {
                                      Get.to(() => GradientContainerWidget(
                                                colors:
                                                    ColorManager.gradientColors,
                                                child: Scaffold(
                                                  appBar: AppBar(),
                                                  body: Center(
                                                    child: Const.emptyWidget(
                                                        context,
                                                        text: 'No Data'),
                                                  ),
                                                ),
                                              )
                                          // AppRoute.monitorDetailsRoute,
                                          // arguments: {'text': e.text,},
                                          );
                                    }
                                  },
                                  text: e.text,
                                  image: e.image,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s0_5,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(AppMargin.m10),
                decoration: BoxDecoration(
                    color: ColorManager.appBarColor.withOpacity(.75),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: ColorManager.appBarColor, width: 4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeScreenListTileWidget(
                              image: AssetsManager.sunIMG,
                              text:
                                  '${((planetModel.sunlight.degree ?? planetModel.sunlight.minimum ?? 0)).toStringAsFixed(0)}  %',
                            ),
                          ),
                          VerticalDivider(
                            color: ColorManager.white,
                          ),
                          Expanded(
                            child: HomeScreenListTileWidget(
                              image: AssetsManager.phIMG,
                              text:
                                  '${(planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0)} ',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0.0,
                      color: ColorManager.white,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeScreenListTileWidget(
                              image: AssetsManager.thermometerIMG,
                              text:
                                  '${planetModel.temperature.degree ?? planetModel.temperature.minimum ?? 0}  C°',
                            ),
                          ),
                          VerticalDivider(
                            color: ColorManager.white,
                          ),
                          Expanded(
                            child: HomeScreenListTileWidget(
                              image: AssetsManager.soilIMG,
                              text:
                                  '${planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0} %',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s0_5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m12),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorManager.appBarColor, width: 3),
                    borderRadius: BorderRadius.circular(14.0)),
                child: LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: 30.h,
                  percent: (planetModel.age ?? 0) > 50
                      ? 1
                      : (planetModel.age ?? 0) / 50,
                  curve: Curves.easeInOut,
                  progressColor: ColorManager.orangeColor,
                  barRadius: Radius.circular(11.0),
                  animation: true,
                  animateFromLastPercent: true,
                  addAutomaticKeepAlive: true,
                  backgroundColor: ColorManager.white,
                  center: Text(
                    ///تعديل كلمةage
                    '${AppString.harvestTime}'
                    ' ${planetModel.age ?? 0} / ${(planetModel.age ?? 0) > 50 ? planetModel.age! : 50}',
                    style: StylesManager.titleBoldTextStyle(
                      size: 20.sp,
                      color: ColorManager.appBarColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: Text(
                    'Sowing Date : ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 204, 147, 3),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.date_range,
                  color: ColorManager.appBarColor,
                ),
                title: Text(
                  DateFormat.yMd()
                      .format(planetModel.createdAt ?? DateTime.now()),
                  style: TextStyle(
                    color: ColorManager.appBarColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.info_outline, //infoooooooooo
                size: 30.sp,
                color: Color.fromARGB(255, 204, 147, 3),
              ),
              onPressed: () {
                context.read<PlanetModelProvider>().planetModel = planetModel;
                Get.to(() => GradientContainerWidget(
                      colors: ColorManager.gradientColors,
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          leading: BackButton(
                            color: ColorManager.white,
                          ),
                        ),
                        body: SingleChildScrollView(
                          child: ChangeNotifierProvider<
                                  PlanetModelProvider>.value(
                              value: Provider.of<PlanetModelProvider>(context),
                              child: Consumer<PlanetModelProvider>(builder:
                                  (context, planetModelProvider, child) {
                                PlanetModel planetModel =
                                    planetModelProvider.planetModel;

                                return Padding(
                                  padding: const EdgeInsets.all(AppPadding.p14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: getWidth(context) / 1.25,
                                        decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            borderRadius: BorderRadius.circular(
                                              24.r,
                                            )),
                                        child: planetModel.url_image != null
                                            ? Image.network(
                                                planetModel.url_image ?? '',
                                              )
                                            : Image.asset(
                                                'assets/images/logo.png'),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ColorManager.appBarColor
                                                .withOpacity(.8),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: ExpansionTile(
                                          title: Text(
                                            'Show Info',
                                            style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: 20.sp,
                                              height: 1,
                                            ),
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p10),
                                              child: Text(
                                                planetModel.description ?? '',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s0_5,
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text: '${1} minute',
                                        // text:
                                        //     '${planetModel.soil_moister.degree
                                        //         ?? planetModel.soil_moister.minimum ?? 0} minute',
                                        image: AssetsManager.seedBagIMG,
                                        label: 'Fertilizing',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text:
                                            // '${planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0} inch',
                                            '1 inch',
                                        image: AssetsManager.waterDropIMG,
                                        label: 'Watering',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,

                                        ///text: '25 c',
                                        text:
                                            ' 0 - ${planetModel.temperature.degree ?? planetModel.temperature.minimum ?? 0} c',
                                        image: AssetsManager.thermometerIMG,
                                        label: 'Temperature',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        //text: '100 %',
                                        text:
                                            '${((planetModel.sunlight.degree ?? planetModel.sunlight.minimum ?? 0)).toStringAsFixed(0)} %',
                                        image: AssetsManager.sunIMG,
                                        label: 'Fully Sunlight',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        // text: '4.5',
                                        text:
                                            '${((planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0)).toStringAsFixed(0)} ',
                                        image: AssetsManager.phIMG,
                                        label: 'Optimal Ph',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        // text: '50 %',
                                        text:
                                            '${((planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0)).toStringAsFixed(0)} %',
                                        image: AssetsManager.soilIMG,
                                        label: 'Soil Moisture',
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),
                      ),
                    ));
              },
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                  onPressed: () async {
                    await PlantController(context: context)
                        .deletePlanetModel(context, planetModel: planetModel);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: ColorManager.appBarColor,
                    size: 30.sp,
                  )))
        ],
      ),
    );
  }
}

class HomeScreenListTileWidget extends StatelessWidget {
  const HomeScreenListTileWidget({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 30.0,
        height: 30.0,
      ),
      title: Text(
        text,
        style: TextStyle(color: ColorManager.white, fontSize: 20.0),
      ),
    );
  }
}


////////////////////////////nouf change 5/5/2024
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_plans/app/pages/details/monitor_details_screen.dart';
// import 'package:smart_plans/app/pages/details/new_monitor_details_screen.dart';
// import 'package:smart_plans/app/widgets/constans.dart';
// import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
// import 'package:smart_plans/core/utils/app_string.dart';
// import '../../core/utils/assets_manager.dart';
// import '../../core/utils/styles_manager.dart';
// import '../../core/utils/values_manager.dart';
// import '../controller/plant_controller.dart';
// import '/app/models/planet_model.dart';
// import '/app/widgets/details_plant_widget.dart';
// import '/core/route/app_route.dart';
// import '/core/utils/app_constant.dart';

// import '../../core/helper/sizer_media_query.dart';
// import '../../core/utils/color_manager.dart';
// import '../controller/provider/plant_provider.dart';

// class MyPlantItem extends StatelessWidget {
//   MyPlantItem({super.key, required this.planetModel});

//   PlanetModel planetModel;

//   String dateUserPicker = 'Select Date';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       width: getWidth(context),
//       margin: EdgeInsets.symmetric(horizontal: AppMargin.m14),
//       decoration: BoxDecoration(
//         color: ColorManager.white,
//         boxShadow: [
//           BoxShadow(
//             color: ColorManager.black.withOpacity(.3),
//             blurRadius: 24,
//           )
//         ],
//         borderRadius: BorderRadius.circular(
//           24.r,
//         ),
//       ),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Column(
//             //ToDo: look to the mainAxisSize and mainAxisAlignment
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     planetModel.url_image != null
//                         ? Image.network(
//                             planetModel.url_image!,
//                             width: getWidth(context),
//                             height: getWidth(context),
//                           )
//                         : Image.asset(
//                             'assets/images/logo.png',
//                             width: getWidth(context),
//                             height: getWidth(context),
//                           ),
//                     Positioned(
//                       bottom: 0.0,
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: AppConstants.plantsDetailsList
//                               .map(
//                                 (e) => DetailsPlantWidget(
//                                   onTap: () {
//                                     context
//                                         .read<PlanetModelProvider>()
//                                         .planetModel = planetModel;
//                                     print(e.text);
//                                     if (e.text == 'Fertilize') {
//                                       context
//                                           .read<PlanetModelProvider>()
//                                           .arguments = {
//                                         'text': e.text,
//                                         'details': {
//                                           'pump': 'Mineral', //'e.pumb',
//                                           'quantity': 'Fertilize Quantity',
//                                           'soil': 'Optimal Ph',
//                                           'repeat': 'Repeat',
//                                         }
//                                       };
//                                       Get.toNamed(
//                                         AppRoute.details2Route,
//                                         arguments: context
//                                             .read<PlanetModelProvider>()
//                                             .arguments,
//                                       );
//                                     } else if (e.text == 'Monitor') {
//                                       Get.to(() => NewMonitorDetailsScreen(),
//                                           transition: Transition.rightToLeft);
//                                     } else if (e.text == 'Water') {
//                                       context
//                                           .read<PlanetModelProvider>()
//                                           .arguments = {
//                                         'text': e.text,
//                                         'details': {
//                                           'pump': 'Water', //'e.pumb',
//                                           'quantity': 'Water Quantity',
//                                           'soil': 'Soil Moisture',
//                                           'repeat': 'Repeat',
//                                         },
//                                       };
//                                       Get.toNamed(
//                                         AppRoute.detailsRoute,
//                                         arguments: context
//                                             .read<PlanetModelProvider>()
//                                             .arguments,
//                                       );
//                                     } else {
//                                       Get.to(() => GradientContainerWidget(
//                                                 colors:
//                                                     ColorManager.gradientColors,
//                                                 child: Scaffold(
//                                                   appBar: AppBar(),
//                                                   body: Center(
//                                                     child: Const.emptyWidget(
//                                                         context,
//                                                         text: 'No Data'),
//                                                   ),
//                                                 ),
//                                               )
//                                           // AppRoute.monitorDetailsRoute,
//                                           // arguments: {'text': e.text,},
//                                           );
//                                     }
//                                   },
//                                   text: e.text,
//                                   image: e.image,
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s0_5,
//               ),
//               Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.all(AppMargin.m10),
//                 decoration: BoxDecoration(
//                     color: ColorManager.appBarColor.withOpacity(.75),
//                     borderRadius: BorderRadius.circular(8),
//                     border:
//                         Border.all(color: ColorManager.appBarColor, width: 4)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     HomeScreenListTileWidget(
//                       image: AssetsManager.sunIMG,
//                       text:
//                           'Fully Sunlight  ${((planetModel.sunlight.degree ?? planetModel.sunlight.minimum ?? 0) / 10).toStringAsFixed(0)}  %',
//                     ),
//                     const Divider(
//                       height: 0.0,
//                     ),
//                     HomeScreenListTileWidget(
//                       image: AssetsManager.thermometerIMG,
//                       text:
//                           'Temperature  ${planetModel.temperature.degree ?? planetModel.temperature.minimum ?? 0}  C°',
//                     ),
//                     const Divider(
//                       height: 0.0,
//                     ),
//                     // HomeScreenListTileWidget(
//                     //   image: AssetsManager.soilIMG,
//                     //   text:
//                     //       'Soil Moistre  ${planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0}  %',
//                     // ),
//                     // const Divider(
//                     //   height: 0.0,
//                     // ),
//                     // HomeScreenListTileWidget(
//                     //   image: AssetsManager.phIMG,
//                     //   text:
//                     //       'Optimal Ph  ${planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0}  ',
//                     // ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s0_5,
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: AppMargin.m12),
//                 decoration: BoxDecoration(
//                     border:
//                         Border.all(color: ColorManager.appBarColor, width: 3),
//                     borderRadius: BorderRadius.circular(14.0)),
//                 child: LinearPercentIndicator(
//                   padding: EdgeInsets.zero,
//                   lineHeight: 30.h,
//                   percent: (planetModel.age ?? 0) > 50
//                       ? 1
//                       : (planetModel.age ?? 0) / 50,
//                   curve: Curves.easeInOut,
//                   progressColor: ColorManager.orangeColor,
//                   barRadius: Radius.circular(11.0),
//                   animation: true,
//                   animateFromLastPercent: true,
//                   addAutomaticKeepAlive: true,
//                   backgroundColor: ColorManager.white,
//                   center: Text(
//                     ///تعديل كلمةage
//                     '${AppString.harvestTime}'
//                     ' ${planetModel.age ?? 0} / ${(planetModel.age ?? 0) > 50 ? planetModel.age! : 50}',
//                     style: StylesManager.titleBoldTextStyle(
//                       size: 20.sp,
//                       color: ColorManager.appBarColor,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: AppSize.s10,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     'Sowing Date : ',
//                     style: TextStyle(
//                         color: ColorManager.brownColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.date_range,
//                   color: ColorManager.appBarColor,
//                 ),
//                 title: Text(
//                   DateFormat.yMd()
//                       .format(planetModel.createdAt ?? DateTime.now()),
//                   style: TextStyle(
//                     color: ColorManager.appBarColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: IconButton(
//               icon: Icon(
//                 Icons.info_outline, //infoooooooooo
//                 size: 30.sp,
//                 color: ColorManager.orangeColor,
//               ),
//               onPressed: () {
//                 context.read<PlanetModelProvider>().planetModel = planetModel;
//                 Get.to(() => GradientContainerWidget(
//                       colors: ColorManager.gradientColors,
//                       child: Scaffold(
//                         appBar: AppBar(
//                           backgroundColor: Colors.transparent,
//                           leading: BackButton(
//                             color: ColorManager.white,
//                           ),
//                         ),
//                         body: SingleChildScrollView(
//                           child: ChangeNotifierProvider<
//                                   PlanetModelProvider>.value(
//                               value: Provider.of<PlanetModelProvider>(context),
//                               child: Consumer<PlanetModelProvider>(builder:
//                                   (context, planetModelProvider, child) {
//                                 PlanetModel planetModel =
//                                     planetModelProvider.planetModel;

//                                 return Padding(
//                                   padding: const EdgeInsets.all(AppPadding.p14),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: double.infinity,
//                                         height: getWidth(context) / 1.25,
//                                         decoration: BoxDecoration(
//                                             color: ColorManager.white,
//                                             borderRadius: BorderRadius.circular(
//                                               24.r,
//                                             )),
//                                         child: planetModel.url_image != null
//                                             ? Image.network(
//                                                 planetModel.url_image ?? '')
//                                             : Image.asset(
//                                                 'assets/images/logo.png'),
//                                       ),
//                                       const SizedBox(
//                                         height: AppSize.s20,
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: ColorManager.appBarColor
//                                                 .withOpacity(.8),
//                                             borderRadius:
//                                                 BorderRadius.circular(12.0)),
//                                         child: ExpansionTile(
//                                           title: Text(
//                                             'Show Info',
//                                             style: TextStyle(
//                                               color: ColorManager.white,
//                                               fontSize: 20.sp,
//                                               height: 1,
//                                             ),
//                                           ),
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.all(
//                                                   AppPadding.p10),
//                                               child: Text(
//                                                 planetModel.description ?? '',
//                                                 style: TextStyle(
//                                                   fontSize: 16.sp,
//                                                   height: 2,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: AppSize.s0_5,
//                                       ),
//                                       DetailsPlantLineWidget(
//                                         onTap: null,
//                                         active: false,
//                                         text: '${1} minute',
//                                         // text:
//                                         //     '${planetModel.soil_moister.degree
//                                         //         ?? planetModel.soil_moister.minimum ?? 0} minute',
//                                         image: AssetsManager.seedBagIMG,
//                                         label: 'Fertilizing',
//                                       ),
//                                       DetailsPlantLineWidget(
//                                         onTap: null,
//                                         active: false,
//                                         text:
//                                             // '${planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0} inch',
//                                             '1 inch',
//                                         image: AssetsManager.waterDropIMG,
//                                         label: 'Watering',
//                                       ),
//                                       DetailsPlantLineWidget(
//                                         onTap: null,
//                                         active: false,
//                                         text:
//                                             ' 0 - ${planetModel.temperature.degree ?? planetModel.temperature.minimum ?? 0} c',
//                                         image: AssetsManager.thermometerIMG,
//                                         label: 'Temperature',
//                                       ),
//                                       DetailsPlantLineWidget(
//                                         onTap: null,
//                                         active: false,
//                                         text:
//                                             '${((planetModel.sunlight.degree ?? planetModel.sunlight.minimum ?? 0)).toStringAsFixed(0)} %',
//                                         image: AssetsManager.sunIMG,
//                                         label: 'Fully Sunlight',
//                                       ),
//                                       DetailsPlantLineWidget(
//                                         onTap: null,
//                                         active: false,
//                                         text:
//                                             '${((planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0)).toStringAsFixed(0)} ',
//                                         image: AssetsManager.phIMG,
//                                         label: 'Optimal Ph',
//                                       ),
//                                       DetailsPlantLineWidget(
//                                         onTap: null,
//                                         active: false,
//                                         text:
//                                             '${((planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0)).toStringAsFixed(0)} %',
//                                         image: AssetsManager.soilIMG,
//                                         label: 'Soil Moister',
//                                       ),
//                                       const SizedBox(
//                                         height: AppSize.s20,
//                                       ),
//                                       // Container(
//                                       //   decoration: BoxDecoration(
//                                       //       color: ColorManager.appBarColor
//                                       //           .withOpacity(.7),
//                                       //       borderRadius:
//                                       //           BorderRadius.circular(12.0)),
//                                       //   child: ExpansionTile(
//                                       //     title: Text('Show Info'),
//                                       //     children: [
//                                       //       Padding(
//                                       //         padding: const EdgeInsets.all(
//                                       //             AppPadding.p12),
//                                       //         child: Text(
//                                       //           planetModel.description ?? '',
//                                       //           style: TextStyle(
//                                       //             fontSize: 16.sp,
//                                       //             height: 1.6,
//                                       //           ),
//                                       //         ),
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       const SizedBox(
//                                         height: AppSize.s20,
//                                       ),
//                                       // Container(
//                                       //   decoration: BoxDecoration(
//                                       //       color: ColorManager.appBarColor
//                                       //           .withOpacity(.7),
//                                       //       borderRadius:
//                                       //           BorderRadius.circular(12.0)),
//                                       //   child: ExpansionTile(
//                                       //     leading: SizedBox(
//                                       //       width: 45, // Adjust width as needed
//                                       //       height:
//                                       //           45, // Adjust height as needed
//                                       //       child: Image.asset(
//                                       //           'assets/icons/soil.png'),
//                                       //     ),
//                                       //     title: Text(
//                                       //         'Soil Moister' +
//                                       //             '  ${((planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0)).toStringAsFixed(0)} %',
//                                       //         style: TextStyle(
//                                       //             color: ColorManager.white,
//                                       //             fontWeight: FontWeight.normal,
//                                       //             fontSize: 20.sp)),
//                                       //     children: [
//                                       //       Padding(
//                                       //         padding: const EdgeInsets.all(
//                                       //             AppPadding.p12),
//                                       //         child: Text(
//                                       //           'Show Info Show Info Show Info Show Info Show Info Show Info Show Info Show Info Show Info Show Info',
//                                       //           style: TextStyle(
//                                       //             fontSize: 16.sp,
//                                       //             height: 1.6,
//                                       //           ),
//                                       //         ),
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 );
//                               })),
//                         ),
//                       ),
//                     ));
//               },
//             ),
//           ),
//           Positioned(
//               top: 0,
//               left: 0,
//               child: IconButton(
//                   onPressed: () async {
//                     await PlantController(context: context)
//                         .deletePlanetModel(context, planetModel: planetModel);
//                   },
//                   icon: Icon(
//                     Icons.cancel_outlined,
//                     color: ColorManager.appBarColor,
//                     size: 30.sp,
//                   )))
//         ],
//       ),
//     );
//   }
// }

// class HomeScreenListTileWidget extends StatelessWidget {
//   const HomeScreenListTileWidget({
//     super.key,
//     required this.image,
//     required this.text,
//   });

//   final String image;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.asset(
//         image,
//         width: 30.0,
//         height: 30.0,
//       ),
//       title: Text(
//         text,
//         style: TextStyle(
//           color: ColorManager.white,
//         ),
//       ),
//     );
//   }
// }

//////////

/// OLD CODE
/*
return Container(
      clipBehavior: Clip.hardEdge,
      width: getWidth(context),
      margin: EdgeInsets.symmetric(horizontal: AppMargin.m12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(.3),
            blurRadius: 24,
          )
        ],
        borderRadius: BorderRadius.circular(
          24.r,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            //ToDo: look to the mainAxisSize and mainAxisAlignment
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: planetModel.url_image != null
                      ? Image.network(
                          planetModel.url_image!,
                          width: getWidth(context),
                          height: getWidth(context),
                        )
                      : Image.asset(
                          'assets/images/logo.png',
                          width: getWidth(context),
                          height: getWidth(context),
                        )),
              Container(
                width: getWidth(context),
                height: getWidth(context) / 5,
                color: ColorManager.gradientColor2,
              )
            ],
          ),
          Positioned(
            bottom: (getWidth(context) / 5) / 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppConstants.plantsDetailsList
                  .map(
                    (e) => DetailsPlantWidget(
                      onTap: () {
                        context.read<PlanetModelProvider>().planetModel =
                            planetModel;
                        print(e.text);
                        if (e.text == 'Fertilize') {
                          context.read<PlanetModelProvider>().arguments = {
                            'text': e.text,
                            'details': {
                              'pump': 'Mineral', //'e.pumb',
                              'quantity': 'Fertilize Quantity',
                              'soil': 'Optimal Ph',
                              'repeat': 'Repeat',
                            }
                          };
                          Get.toNamed(
                            AppRoute.details2Route,
                            arguments:
                                context.read<PlanetModelProvider>().arguments,
                          );
                        } else if (e.text == 'Water') {
                          context.read<PlanetModelProvider>().arguments = {
                            'text': e.text,
                            'details': {
                              'pump': 'Water', //'e.pumb',
                              'quantity': 'Water Quantity',
                              'soil': 'Soil Moisture',
                              'repeat': 'Repeat',
                            },
                          };
                          Get.toNamed(
                            AppRoute.detailsRoute,
                            arguments:
                                context.read<PlanetModelProvider>().arguments,
                          );
                        } else {
                          Get.to(() => Scaffold(
                                    appBar: AppBar(),
                                    body: Center(
                                      child: Const.emptyWidget(context,
                                          text: 'No Data'),
                                    ),
                                  )
                              // AppRoute.monitorDetailsRoute,
                              // arguments: {'text': e.text,},
                              );
                        }
                      },
                      text: e.text,
                      image: e.image,
                    ),
                  )
                  .toList(),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 30.sp,
              ),
              onPressed: () {
                context.read<PlanetModelProvider>().planetModel = planetModel;
                Get.to(() => GradientContainerWidget(
                      colors: ColorManager.gradientColors,
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          leading: BackButton(
                            color: ColorManager.secondary,
                          ),
                        ),
                        body: SingleChildScrollView(
                          child: ChangeNotifierProvider<
                                  PlanetModelProvider>.value(
                              value: Provider.of<PlanetModelProvider>(context),
                              child: Consumer<PlanetModelProvider>(builder:
                                  (context, planetModelProvider, child) {
                                PlanetModel planetModel =
                                    planetModelProvider.planetModel;

                                return Padding(
                                  padding: const EdgeInsets.all(AppPadding.p16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: getWidth(context) / 1.25,
                                        decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            borderRadius: BorderRadius.circular(
                                              24.r,
                                            )),
                                        child: planetModel.url_image != null
                                            ? Image.network(
                                                planetModel.url_image ?? '')
                                            : Image.asset(
                                                'assets/images/logo.png'),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),

                                      LinearPercentIndicator(
                                        padding: EdgeInsets.zero,
                                        lineHeight: 60.h,
                                        percent: (planetModel.age ?? 0) > 50
                                            ? 1
                                            : (planetModel.age ?? 0) / 50,
                                        curve: Curves.easeInOut,
                                        progressColor:
                                            ColorManager.progressColor,
                                        barRadius: Radius.circular(12.0),
                                        animation: true,
                                        animateFromLastPercent: true,
                                        addAutomaticKeepAlive: true,
                                        backgroundColor: ColorManager.secondary
                                            .withOpacity(.7),
                                        center: Text(
                                          ///تعديل كلمةage
                                          '${AppString.harvestTime}'
                                          ' ${planetModel.age ?? 0} / ${(planetModel.age ?? 0) > 50 ? planetModel.age! : 50}',
                                          style:
                                              StylesManager.titleBoldTextStyle(
                                            size: 20.sp,
                                            color: ColorManager.primary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),

                                      ///جديد
                                      /// تم اضافة التاريخ هنا عندما يضغط المستخدم يقوم باختيار تاريخ ومن ثم يظهر التاريخ بعد الاختيار
                                      StatefulBuilder(
                                          builder: (context, dateSetState) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: ColorManager.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: ListTile(
                                            //TODO select date or show date
                                            /// the date is planetModel.createdAt
                                            onTap: () async {
                                              final picker =
                                                  await showDatePicker(
                                                      context: context,

                                                      ///تحديد الوقت الحالي
                                                      initialDate:
                                                          DateTime.now(),

                                                      //في حال الرغبة في وضع التاريخ الحالي هو عمر النبتة الحقيقي
                                                      // DateTime.now().subtract(Duration(days: (planetModel.age??0).toInt()))
                                                      ///تحديد اول تاريخ
                                                      firstDate: planetModel
                                                              .createdAt ??
                                                          DateTime.now()
                                                              .subtract(Duration(
                                                                  days: (planetModel
                                                                              .age ??
                                                                          0)
                                                                      .toInt())),

                                                      //في حال الرغبة في وضع اول تاريخ قبل 50 يوم
                                                      // DateTime.now().subtract(Duration(50).toInt()))
                                                      ///تحديد اخر تاريخ يمكن اختياره
                                                      lastDate: DateTime(2100)

                                                      //في حال الرغبة في وضع اخر تاريخ هو تاريخ اليوم
                                                      // DateTime.now()
                                                      );

                                              if (picker != null) {
                                                dateSetState(() {
                                                  ///عرض التاريخ
                                                  dateUserPicker =
                                                      DateFormat.yMd()
                                                          .format(picker);
                                                  planetModel.createdAt =
                                                      picker;
                                                  planetModel.age =
                                                      DateTime.now()
                                                          .difference(picker)
                                                          .inDays;
                                                  planetModel.age ??= 0;
                                                  planetModel.age =
                                                      (planetModel.age!) < 0
                                                          ? (-1 *
                                                              planetModel.age!)
                                                          : planetModel.age;

                                                  PlantController(
                                                          context: context)
                                                      .updatePlanetModel2(
                                                          context,
                                                          planetModel:
                                                              planetModel);
                                                });
                                              }
                                            },
                                            leading: Icon(
                                              Icons.date_range,
                                              color: ColorManager.primary,
                                            ),
                                            title: Text(
                                              '${DateFormat.yMd().format(planetModel.createdAt ?? DateTime.now())}',
                                              style: TextStyle(
                                                  color: ColorManager.primary),
                                            ),
                                          ),
                                        );
                                      }),

                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text: '${1} minute',
                                        // text:
                                        //     '${planetModel.soil_moister.degree
                                        //         ?? planetModel.soil_moister.minimum ?? 0} minute',
                                        image: AssetsManager.seedBagIMG,
                                        label: 'Fertilizing',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text:
                                            '${planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0} inch',
                                        image: AssetsManager.waterDropIMG,
                                        label: 'Watering',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text:
                                            ' 0 - ${planetModel.temperature.degree ?? planetModel.temperature.minimum ?? 0} c',
                                        image: AssetsManager.thermometerIMG,
                                        label: 'Temperature',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text:
                                            '${((planetModel.sunlight.degree ?? planetModel.sunlight.minimum ?? 0) / 10).toStringAsFixed(0)} %',
                                        image: AssetsManager.sunIMG,
                                        label: 'Fully Sunlight',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text:
                                            '${((planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0) / 10).toStringAsFixed(0)} %',
                                        image: AssetsManager.sunIMG,
                                        label: 'Optimal Ph',
                                      ),
                                      DetailsPlantLineWidget(
                                        onTap: null,
                                        active: false,
                                        text:
                                            '${((planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0) / 10).toStringAsFixed(0)} %',
                                        image: AssetsManager.sunIMG,
                                        label: 'Soil Moister',
                                      ),
                                      const SizedBox(
                                        height: AppSize.s20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ColorManager.secondary
                                                .withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        child: ExpansionTile(
                                          title: Text('Show Info'),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p12),
                                              child: Text(
                                                planetModel.description ?? '',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  height: 1.6,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),
                      ),
                    ));
              },
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                  onPressed: () async {
                    await PlantController(context: context)
                        .deletePlanetModel(context, planetModel: planetModel);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: ColorManager.primary,
                    size: 30.sp,
                  )))
        ],
      ),
    );

 */
