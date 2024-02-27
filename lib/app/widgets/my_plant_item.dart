import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/pages/details/monitor_details_screen.dart';
import 'package:smart_plans/app/widgets/constans.dart';
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
   MyPlantItem({
    super.key,
    required  this.planetModel
  });
  PlanetModel planetModel;

  String dateUserPicker = 'Select Date';
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: getWidth(context),
      decoration: BoxDecoration(
        color: ColorManager.white,
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

              Flexible(child:
      planetModel.url_image!=null?
              Image.network(planetModel.url_image!):
           Image.asset('assets/images/logo.png')
              ),
              Container(
                width: getWidth(context),
                height: getWidth(context) / 5,
                color: ColorManager.secondary,
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
                        context.read<PlanetModelProvider>().planetModel=planetModel;
                        print(e.text);
                        if (e.text == 'Fertilize') {
                          context.read<PlanetModelProvider>().arguments={
                                'text': e.text,
                                'details':{
                                'pump':'Mineral',//'e.pumb',
                                'quantity':'Fertilize Quantity',
                                'soil':'Ph',
                                'repeat':'Repeat',
                                }};
                          Get.toNamed(
                            AppRoute.details2Route,
                            arguments:context.read<PlanetModelProvider>().arguments,
                          );
                        }
                        else if (e.text == 'Water') {
                          context.read<PlanetModelProvider>().arguments={
                            'text': e.text,
                            'details':{
                              'pump':'Water',//'e.pumb',
                              'quantity':'Water Quantity',
                              'soil':'Soil Moisture',
                              'repeat':'Repeat',
                            },

                          };
                          Get.toNamed(
                            AppRoute.detailsRoute,
                            arguments: context.read<PlanetModelProvider>().arguments,
                          );
                        }
                        else {
                          Get.to(
                              ()=>Scaffold(
                                appBar: AppBar(),
                                body: Center(
                                  child: Const.emptyWidget(context,text: 'No Data'),
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
              icon: Icon(Icons.info_outline,size: 30.sp,),
              onPressed: (){
               context.read<PlanetModelProvider>().planetModel=planetModel;
               Get.to(()=>Scaffold(
                 appBar: AppBar(
                   title: Text(
                     ''
                     // Get.arguments['text'],
                   ),
                 ),
                 body: SingleChildScrollView(
                   child:
                   ChangeNotifierProvider<PlanetModelProvider>.value(
                       value: Provider.of<PlanetModelProvider>(context),
                       child: Consumer<PlanetModelProvider>(
                           builder: (context, planetModelProvider, child) {
                             PlanetModel planetModel = planetModelProvider.planetModel;

                             return
                               Padding(
                                 padding: const EdgeInsets.all(AppPadding.p16),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
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
                                       child:
                                       planetModel.url_image!=null?
                                       Image.network(planetModel.url_image??''):
                                       Image.asset('assets/images/logo.png'),
                                     ),
                                     const SizedBox(
                                       height: AppSize.s20,
                                     ),
                                     // CarouselSlider(
                                     //   options: CarouselOptions(
                                     //     height: 150.h,
                                     //     viewportFraction: .35,
                                     //     initialPage: 0,
                                     //     enableInfiniteScroll: false,
                                     //     reverse: false,
                                     //     autoPlayCurve: Curves.fastOutSlowIn,
                                     //     enlargeCenterPage: true,
                                     //     enlargeFactor: 0.3,
                                     //   ),
                                     //   items: AppConstants.plantsList.map((i) {
                                     //     return Builder(
                                     //       builder: (BuildContext context) {
                                     //         return Container(
                                     //           width: 150.w,
                                     //           height: 150.w,
                                     //           decoration: BoxDecoration(
                                     //               color: ColorManager.white,
                                     //               borderRadius: BorderRadius.circular(20.r)),
                                     //           child: Image.asset('assets/images/strawberries.png'),
                                     //         );
                                     //       },
                                     //     );
                                     //   }).toList(),
                                     // ),

                                     Text(
                                       planetModel.description??'',
                                       // 'The garden strawberry is a widely grown hybrid species of the genus Fragaria, collectively known as the strawberries, which are cultivated worldwide for their fruit.',
                                       textAlign: TextAlign.center,
                                       style: TextStyle(
                                         fontSize: 16.sp,
                                         height: 1.6,
                                       ),
                                     ),
                                     const SizedBox(height: AppSize.s10,),
                                     LinearPercentIndicator(
                                       padding: EdgeInsets.zero,
                                       lineHeight: 60.h,
                                       percent:(planetModel.age??0)>50?1: (planetModel.age??0)/50,
                                       curve: Curves.easeInOut,
                                       progressColor: ColorManager.progressColor,
                                       barRadius: Radius.circular(100.r),
                                       animation: true,
                                       animateFromLastPercent: true,
                                       addAutomaticKeepAlive: true,
                                       backgroundColor: ColorManager.secondary.withOpacity(.7),
                                       center: Text(
                                         ///تعديل كلمةage
                                         '${AppString.harvestTime}'
                                             ' ${planetModel.age??0} / ${(planetModel.age??0)>50?planetModel.age!:50}',
                                         style: StylesManager.titleBoldTextStyle(
                                           size: 20.sp,
                                           color: ColorManager.primary,
                                         ),
                                       ),
                                     ),
                                     const SizedBox(height: AppSize.s10,),
                                     ///جديد
                                     /// تم اضافة التاريخ هنا عندما يضغط المستخدم يقوم باختيار تاريخ ومن ثم يظهر التاريخ بعد الاختيار
                                     StatefulBuilder(builder: (context,dateSetState){
                                       return ListTile(
                                         onTap: ()async{
                                           final picker = await showDatePicker(
                                               context: context,
                                               ///تحديد الوقت الحالي
                                               initialDate: DateTime.now(),
                                               ///تحديد اول تاريخ
                                               firstDate: DateTime.now().subtract(Duration(days: (planetModel.age??0).toInt())),
                                               ///تحديد اخر تاريخ يمكن اختياره
                                               lastDate: DateTime(2100)
                                           );

                                           if(picker != null){
                                             dateSetState((){
                                               ///عرض التاريخ
                                               dateUserPicker = DateFormat.yMd().format(picker);
                                               planetModel.age=DateTime.now().difference(picker).inDays;
                                               planetModel.age=(planetModel.age??0)<0?0:planetModel.age;
                                               PlantController(context: context).updatePlanetModel2(context, planetModel: planetModel);
                                             });
                                           }
                                         },
                                         leading: Icon(Icons.date_range,color: ColorManager.white,),
                                         title: Text(dateUserPicker,style: TextStyle(
                                           color: ColorManager.white
                                         ),),
                                       );
                                     }),
                                     const SizedBox(height: AppSize.s10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,

                                       children: [
                                         DetailsPlantWidget(
                                           onTap: null,
                                           active: false,
                                           text: '${planetModel.soil_moister.degree??planetModel.soil_moister.minimum??0} g',
                                           image: AssetsManager.seedBagIMG,
                                         ),
                                         DetailsPlantWidget(
                                           onTap: null,
                                           active: false,
                                           text: '${planetModel.soil_ph.degree??planetModel.soil_ph.minimum??0} inch',
                                           image: AssetsManager.waterDropIMG,
                                         ),
                                       ],
                                     ),
                                     const SizedBox(height: AppSize.s10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         DetailsPlantWidget(
                                           onTap: null,
                                           active: false,
                                           text: '${planetModel.temperature.degree??planetModel.temperature.minimum??0} c',
                                           image: AssetsManager.thermometerIMG,
                                         ),
                                         DetailsPlantWidget(
                                           onTap: null,
                                           active: false,
                                           text: '${planetModel.sunlight.degree??planetModel.sunlight.minimum??0}',
                                           image: AssetsManager.sunIMG,
                                         ),

                                       ],
                                     )
                                   ],
                                 ),
                               ) ;})),
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
                await PlantController(context: context).deletePlanetModel(context, planetModel: planetModel);

              }, icon:
          Icon(Icons.cancel_outlined,color: ColorManager.primary,
            size: 30.sp,
          )))
        ],
      ),
    );
  }
}
