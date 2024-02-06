import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/values_manager.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/styles_manager.dart';
import '../../controller/provider/plant_provider.dart';
import '../../models/planet_model.dart';
import '../../widgets/details_plant_widget.dart';

class MonitorDetailsScreen extends StatelessWidget {
   MonitorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // PlanetModel planetModel= context.read<PlanetModelProvider>().planetModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments['text'],
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
                Image.asset('assets/images/strawberries.png'),
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
                  '${AppString.age} ${planetModel.age??0} / ${50}',
                  style: StylesManager.titleBoldTextStyle(
                    size: 20.sp,
                    color: ColorManager.primary,
                  ),
                ),
              ),

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
    );
  }
}
