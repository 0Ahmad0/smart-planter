import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
import '../../../core/route/app_route.dart';
import '../../controller/utils/function_helper_view_provider.dart';
import '/app/models/planet_model.dart';
import '/app/widgets/button_app.dart';
import '/core/helper/sizer_media_query.dart';
import '/core/utils/app_string.dart';
import '/core/utils/styles_manager.dart';
import '/core/utils/values_manager.dart';
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
    var arguments = context.read<PlanetModelProvider>().arguments;
    return GradientContainerWidget(
      colors: ColorManager.gradientColors,
      child: Scaffold(
        appBar: AppBar(
          title: Text(arguments['text']),
        ),
        body: ChangeNotifierProvider<PlanetModelProvider>.value(
            value: Provider.of<PlanetModelProvider>(context),
            child: Consumer<PlanetModelProvider>(
                builder: (context, planetModelProvider, child) {
              PlanetModel planetModel = planetModelProvider.planetModel;
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: getWidth(context),
                      decoration: BoxDecoration(
                          color: ColorManager.appBarColor,
                          borderRadius: BorderRadius.circular(100.r)),
                      child: StatefulBuilder(builder: (context, pumpState) {
                        return ListTile(
                          ///
                          /*
                    هنا كود الريال تايم
                     */
                          ///
                          onTap: () {
                            isPumpOn = !isPumpOn;
                            planetModel.pump_fertilizing = isPumpOn ? 1 : 0;
                            pumpState(() {});

                            ///
                            /*
                      updatePlanetModel2
                      هذا التابع الذي يتحكم بارسال وجلب الداتا من الريال تايم داتا بيز
                       */
                            ///
                            PlantController(context: context)
                                .updatePlanetModel2(context,
                                    planetModel: planetModel);
                          },
                          title: Text(
                            AppString.pump + arguments['details']['pump'],
                            style: StylesManager.titleBoldTextStyle(
                                size: 20.sp, color: ColorManager.white),
                          ),
                          trailing: Switch(
                            thumbColor: MaterialStateProperty.all(
                                ColorManager.appBarColor),
                            activeTrackColor:
                                ColorManager.fwhite.withOpacity(.5),
                            value: planetModel.pump_fertilizing == 1,
                            onChanged: (bool value) {
                              isPumpOn = value;
                              planetModel.pump_fertilizing = isPumpOn ? 1 : 0;
                              pumpState(() {});
                              PlantController(context: context)
                                  .updatePlanetModel2(context,
                                      planetModel: planetModel);
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    // Text(
                    //   arguments['details']['quantity'],
                    //   style: StylesManager.titleBoldTextStyle(
                    //     size: 20.sp,
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //         child: DetailsContainer(
                    //       value:'${planetModel.sunlight.degree??planetModel.sunlight.minimum??0} inch' //'10',
                    //     )),
                    //     const SizedBox(
                    //       width: AppSize.s10,
                    //     ),
                    //     DetailsButton(icon: Icons.add,onPressed: (){
                    //
                    //
                    //       if(planetModel.sunlight.maximum==null||(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)<(planetModel.sunlight.maximum!)) {
                    //         planetModel.sunlight.degree =
                    //             (planetModel.sunlight.degree ??
                    //                 planetModel.sunlight.minimum ?? 0) + 1;
                    //         PlantController(context: context).updatePlanetModel2(context, planetModel: planetModel);
                    //       }
                    //       setState(() {
                    //
                    //       });
                    //     },),
                    //     const SizedBox(
                    //       width: AppSize.s10,
                    //     ),
                    //     DetailsButton(icon: Icons.remove,onPressed: (){
                    //
                    //       if(planetModel.sunlight.minimum==null||(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)>(planetModel.sunlight.minimum!))
                    //      {
                    //         planetModel.sunlight.degree=(planetModel.sunlight.degree??planetModel.sunlight.minimum??0)-1;
                    //         PlantController(context: context).updatePlanetModel2(context, planetModel: planetModel);
                    //      }
                    //       setState(() {
                    //
                    //       });
                    //       },),
                    //   ],
                    // ),
                    //
                    // ///
                    // const SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Text(
                      arguments['details']['soil'] + " 5.5",
                      style: StylesManager.titleBoldTextStyle(
                        size: 20.sp,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s4,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: DetailsContainer(
                                value:
                                    '${planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0}' //'10',
                                )),
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        DetailsButton(
                          icon: Icons.add,
                          onPressed: () {
                            if (planetModel.soil_ph.maximum == null ||
                                (planetModel.soil_ph.degree ??
                                        planetModel.soil_ph.minimum ??
                                        0) <
                                    (planetModel.soil_ph.maximum!)) {
                              planetModel.soil_ph.degree =
                                  (planetModel.soil_ph.degree ??
                                          planetModel.soil_ph.minimum ??
                                          0) +
                                      1;
                              PlantController(context: context)
                                  .updatePlanetModel2(context,
                                      planetModel: planetModel);
                            }
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        DetailsButton(
                          icon: Icons.remove,
                          onPressed: () {
                            if (planetModel.soil_ph.minimum == null ||
                                (planetModel.soil_ph.degree ??
                                        planetModel.soil_ph.minimum ??
                                        0) >
                                    (planetModel.soil_ph.minimum!)) {
                              planetModel.soil_ph.degree =
                                  (planetModel.soil_ph.degree ??
                                          planetModel.soil_ph.minimum ??
                                          0) -
                                      1;
                              PlantController(context: context)
                                  .updatePlanetModel2(context,
                                      planetModel: planetModel);
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    ///

                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    //ToDo :In real Time Database not same water Database
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.appBarColor,
                          borderRadius:
                              BorderRadius.circular(30)), //old circuilar(8)
                      child: ListTile(
                        // contentPadding: EdgeInsets.zero,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.scheduleRoute);
                        },
                        leading:
                            Icon(Icons.date_range, color: ColorManager.white),
                        title: Text(
                          'Show Schedule',
                          style: StylesManager.titleNormalTextStyle(
                              color: ColorManager.white, size: 16.sp),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ColorManager.white,
                        ),
                      ),
                    ),

                    // Text(
                    //   arguments['details']['repeat'],
                    //   style: StylesManager.titleBoldTextStyle(
                    //     size: 20.sp,
                    //   ),
                    // ),
                    // DropdownButtonFormField(
                    //   value:
                    //   PlantController(context: context)
                    //       .getListRepeat().contains(planetModel.repeat_fertilizing?.toInt())?planetModel.repeat_fertilizing?.toInt():0 ,
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_down,
                    //       color: ColorManager.primary,
                    //     ),
                    //     decoration: InputDecoration(
                    //
                    //         filled: true,
                    //         fillColor: ColorManager.secondary,
                    //         contentPadding:
                    //             EdgeInsets.symmetric(horizontal: AppSize.s12),
                    //         border: OutlineInputBorder(),
                    //         hintText: 'value'),
                    //     items: PlantController( context: context).getListRepeat()
                    //         .map((e) => DropdownMenuItem(
                    //               child: Text(
                    //                 'Every ${convertMinutesToTime(e)}',
                    //                 style: StylesManager.titleBoldTextStyle(
                    //                     size: 20.sp, color: ColorManager.primary),
                    //               ),
                    //               value: e,
                    //             ))
                    //         .toList(),
                    //     onChanged: (value) async {
                    //       planetModel.repeat_fertilizing=value;
                    //
                    //        PlantController(context: context).updatePlanetModel2(context, planetModel: planetModel);
                    //     }),

                    const Spacer(),
                    // ButtonApp(
                    //   onPressed: () async {
                    //      PlantController(context: context).updatePlanetModel(context, planetModel: planetModel);
                    //   },
                    //   text: AppString.apply,
                    //   backgroundColor: ColorManager.secondary,
                    //   textColor: ColorManager.primary,
                    // )
                  ],
                ),
              );
            })),
      ),
    );
  }
}
