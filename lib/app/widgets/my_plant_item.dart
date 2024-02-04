import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
      planetModel.url_image!=null?
              Image.network(planetModel.url_image??''):
              Image.asset('assets/images/strawberries.png')),
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
                                'pump':'${planetModel.fertilizer_quantity.value} ${planetModel.fertilizer_quantity.type}',//'e.pumb',
                                'quantity':'e.quantity',
                                'soil':'e.soil',
                                'repeat':'e.repeat',
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
                              'pump':'${planetModel.water_quantity.value} ${planetModel.water_quantity.type}',//'e.pumb',
                              'quantity':'e.quantity',
                              'soil':'e.soil',
                              'repeat':'e.repeat',
                            },

                          };
                          Get.toNamed(
                            AppRoute.detailsRoute,
                            arguments: context.read<PlanetModelProvider>().arguments,
                          );
                        }

                        else {
                          Get.toNamed(
                            AppRoute.monitorDetailsRoute,
                            arguments: {'text': e.text,

                            },
                          );
                        }
                      },
                      text: e.text,
                      image: e.image,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
