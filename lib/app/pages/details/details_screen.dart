import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
import 'package:smart_plans/core/route/app_route.dart';
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

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isPumpOn = false;
  late PlantController plantController;
  @override
  void initState() {
    plantController = PlantController(context: context);
    // TODO: implement initState
    super.initState();
  }

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
                        ///
                        /*
                    هنا كود الريال تايم
                     */
                        ///
                        return ListTile(
                          onTap: () {
                            isPumpOn = !isPumpOn;
                            planetModel.pump_watering = isPumpOn ? "1" : "0";
                            pumpState(() {});

                            ///
                            /*
                      updatePlanetModel2
                      هذا التابع الذي يتحكم بارسال وجلب الداتا من الريال تايم داتا بيز
                       */
                            ///
                            plantController.updatePlanetModel2(context,
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
                            value: planetModel.pump_watering == "1",
                            onChanged: (bool value) {
                              isPumpOn = value;
                              planetModel.pump_watering = isPumpOn ? "1" : "0";
                              pumpState(() {});
                              plantController.updatePlanetModel2(context,
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
                    //             value:
                    //                 '${planetModel.temperature.degree
                    //                     ?? planetModel.temperature.minimum ?? 0} inch' //'10',
                    //             )),
                    //     const SizedBox(
                    //       width: AppSize.s10,
                    //     ),
                    //     DetailsButton(
                    //       icon: Icons.add,
                    //       onPressed: () {
                    //         if (planetModel.temperature.maximum == null ||
                    //             (planetModel.temperature.degree ??
                    //                     planetModel.temperature.minimum ??
                    //                     0) <
                    //                 (planetModel.temperature.maximum!))
                    //           {
                    //           planetModel.temperature.degree =
                    //               (planetModel.temperature.degree ??
                    //                       planetModel.temperature.minimum ??
                    //                       0) +
                    //                   1;
                    //           plantController.updatePlanetModel2(context, planetModel: planetModel);
                    //           }
                    //         setState(() {});
                    //       },
                    //     ),
                    //     const SizedBox(
                    //       width: AppSize.s10,
                    //     ),
                    //     DetailsButton(
                    //       icon: Icons.remove,
                    //       onPressed: () {
                    //         if (planetModel.temperature.minimum == null ||
                    //             (planetModel.temperature.degree ??
                    //                     planetModel.temperature.minimum ??
                    //                     0) >
                    //                 (planetModel.temperature.minimum!))
                    //         {  planetModel.temperature.degree =
                    //               (planetModel.temperature.degree ??
                    //                       planetModel.temperature.minimum ??
                    //                       0) -
                    //                   1;
                    //         plantController.updatePlanetModel2(context, planetModel: planetModel);
                    //         }
                    //         setState(() {});
                    //       },
                    //     ),
                    //   ],
                    // ),

                    // ///
                    // const SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Text(
                      arguments['details']['soil'] + " 40%",
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
                                    '${planetModel.soil_moister.degree ?? planetModel.soil_moister.minimum ?? 0} %' //'10',
                                )),
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        DetailsButton(
                          icon: Icons.add,
                          onPressed: () {
                            if (planetModel.soil_moister.maximum == null ||
                                (planetModel.soil_moister.degree ??
                                        planetModel.soil_moister.minimum ??
                                        0) <
                                    (planetModel.soil_moister.maximum!)) {
                              planetModel.soil_moister.degree =
                                  (planetModel.soil_moister.degree ??
                                          planetModel.soil_moister.minimum ??
                                          0) +
                                      1;
                              plantController.updatePlanetModel2(context,
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
                            if (planetModel.soil_moister.minimum == null ||
                                (planetModel.soil_moister.degree ??
                                        planetModel.soil_moister.minimum ??
                                        0) >
                                    (planetModel.soil_moister.minimum!)) {
                              planetModel.soil_moister.degree =
                                  (planetModel.soil_moister.degree ??
                                          planetModel.soil_moister.minimum ??
                                          0) -
                                      1;
                              plantController.updatePlanetModel2(context,
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
                    // Text(
                    //   arguments['details']['repeat'],
                    //   style: StylesManager.titleBoldTextStyle(
                    //     size: 20.sp,
                    //   ),
                    // ),
                    // DropdownButtonFormField(
                    //     value:PlantController(context: context)
                    //         .getListRepeat().contains(planetModel.repeat_watering?.toInt())?planetModel.repeat_watering?.toInt():0 ,
                    //     icon: Icon(
                    //       Icons.keyboard_arrow_down,
                    //       color: ColorManager.primary,
                    //     ),
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: ColorManager.secondary,
                    //         contentPadding:
                    //             EdgeInsets.symmetric(horizontal: AppSize.s12),
                    //         border: OutlineInputBorder(),
                    //         hintText: 'value'),
                    //     items: PlantController(context: context)
                    //         .getListRepeat()
                    //         .map((e) => DropdownMenuItem(
                    //               child: Text(
                    //                 'Every ${convertMinutesToTime(e)}',
                    //                 style: StylesManager.titleBoldTextStyle(
                    //                     size: 20.sp, color: ColorManager.primary),
                    //               ),
                    //               value: e,
                    //             ))
                    //         .toList(),
                    //     onChanged: (value) {
                    //       planetModel.repeat_watering =value;
                    //       plantController.updatePlanetModel2(context, planetModel: planetModel);
                    //     }),
                    // const SizedBox(
                    //   height: AppSize.s20,
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.appBarColor,
                          borderRadius: BorderRadius.circular(
                              30)), // old size circular(8)
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
                    const Spacer(),
                    // ButtonApp(
                    //   onPressed: () {
                    //     PlantController(context: context)
                    //         .updatePlanetModel(context, planetModel: planetModel);
                    //
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

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r), // old size (8,r)
        ),
        minimumSize: Size(50.w, 50.w),
        backgroundColor: ColorManager.appBarColor,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: ColorManager.white,
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: StylesManager.titleNormalTextStyle(
          size: 20.sp, color: ColorManager.white),
      textAlign: TextAlign.center,
      controller: TextEditingController(text: value),
      onTap: null,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          filled: true,
          fillColor: ColorManager.appBarColor),
    );
  }
}
