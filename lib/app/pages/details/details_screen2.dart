
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/models/planet_model.dart';
import 'package:smart_plans/app/models/plant_model.dart';
import 'package:smart_plans/app/widgets/button_app.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../../core/utils/color_manager.dart';
import '../../controller/plant_controller.dart';
import '../../controller/provider/plant_provider.dart';
import 'details_screen.dart';

class DetailsScreen2 extends StatefulWidget {
  const DetailsScreen2({super.key});

  @override
  State<DetailsScreen2> createState() => _DetailsScreen2State();
}

class _DetailsScreen2State extends State<DetailsScreen2> {
  bool isPumpOn = false;

  @override
  Widget build(BuildContext context) {
    PlanetModel planetModel=context.read<PlanetModelProvider>().planetModel;
    var arguments= context.read<PlanetModelProvider>().arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['text']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: getWidth(context),
              height: 60.h,
              decoration: BoxDecoration(
                  color: ColorManager.secondary,
                  borderRadius: BorderRadius.circular(100.r)),
              child: StatefulBuilder(builder: (context, pumpState) {
                return ListTile(
                  onTap: () {
                    isPumpOn = !isPumpOn;
                    pumpState(() {});
                  },
                  title: Text(
                    AppString.pump + arguments['details']['pump'],
                    style: StylesManager.titleBoldTextStyle(
                        size: 20.sp, color: ColorManager.primary),
                  ),
                  trailing: Switch(
                    thumbColor: MaterialStateProperty.all(ColorManager.primary),
                    activeTrackColor: ColorManager.primary.withOpacity(.5),
                    value: isPumpOn,
                    onChanged: (bool value) {
                      isPumpOn = value;
                      pumpState(() {});
                    },
                  ),
                );
              }),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              arguments['details']['quantity'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: DetailsContainer(
                  value:'${planetModel.sunlight.degree??planetModel.sunlight.minimum??0}' //'10',
                )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.add,onPressed: (){

                  if(planetModel.sunlight.maximum==null||(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)<(planetModel.sunlight.maximum!))
                  planetModel.sunlight.degree=(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)+1;
                  setState(() {

                  });
                },),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.remove,onPressed: (){

                  if(planetModel.sunlight.minimum==null||(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)>(planetModel.sunlight.minimum!))
                    planetModel.sunlight.degree=(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)-1;
                  setState(() {

                  });
                  },),
              ],
            ),

            ///
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              arguments['details']['soil'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: DetailsContainer(   value:'${planetModel.soil_moister.degree??planetModel.soil_moister.minimum??0}' //'10',
                    )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.add,onPressed: (){

                  if(planetModel.soil_moister.maximum==null||(planetModel.soil_moister.degree??planetModel.soil_moister.minimum??0)<(planetModel.soil_moister.maximum!))
                    planetModel.soil_moister.degree=(planetModel.soil_moister.degree??planetModel.soil_moister.minimum??0)+1;
                  setState(() {

                  });
                },),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(icon: Icons.remove,onPressed: (){
                  if(planetModel.soil_moister.minimum==null||(planetModel.soil_moister.degree??planetModel.soil_moister.minimum??0)>(planetModel.soil_moister.minimum!))
                    planetModel.soil_moister.degree=(planetModel.soil_moister.degree??planetModel.soil_moister.minimum??0)-1;
                  setState(() {

                  });
                },),

              ],
            ),

            ///

            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              arguments['details']['repeat'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            DropdownButtonFormField(
              value: planetModel.repeat_fertilizing,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorManager.primary,
                ),
                decoration: InputDecoration(

                    filled: true,
                    fillColor: ColorManager.secondary,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: AppSize.s12),
                    border: OutlineInputBorder(),
                    hintText: 'value'),
                items: PlantController( context: context).getListRepeat()
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            e.toString(),
                            style: StylesManager.titleBoldTextStyle(
                                size: 20.sp, color: ColorManager.primary),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  planetModel.repeat_fertilizing=value;
                }),

            const Spacer(),
            ButtonApp(
              onPressed: (){
                PlantController(context: context).updatePlanetModel(context, planetModel: planetModel);
              },
              text: AppString.apply,
              backgroundColor: ColorManager.secondary,
              textColor: ColorManager.primary,
            )
          ],
        ),
      ),
    );
  }
}

