import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
          //  mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child:IconButton(
                      onPressed: () async {
                         await PlantController(context: context).deletePlanetModel(context, planetModel: planetModel);

                      }, icon:
                  RotationTransition(
                    turns: new AlwaysStoppedAnimation(45 / 360),
                    child:  Icon(Icons.add_circle_outline,color: ColorManager.primary,size: getWidth(context)/12 ,),
                  ))
                 ),
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
