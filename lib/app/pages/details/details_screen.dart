import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
    plantController=PlantController(context: context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var arguments = context.read<PlanetModelProvider>().arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['text']),
      ),
      body:
      ChangeNotifierProvider<PlanetModelProvider>.value(
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
              height: 60.h,
              decoration: BoxDecoration(
                  color: ColorManager.secondary,
                  borderRadius: BorderRadius.circular(100.r)),
              child: StatefulBuilder(builder: (context, pumpState) {
                return ListTile(
                  onTap: () {
                    isPumpOn = !isPumpOn;
                    planetModel.pump_watering=isPumpOn;
                    pumpState(() {});
                    plantController.updatePlanetModel2(context, planetModel: planetModel);
                  },
                  title: Text(
                    AppString.pump + arguments['details']['pump'],
                    style: StylesManager.titleBoldTextStyle(
                        size: 20.sp, color: ColorManager.primary),
                  ),
                  trailing: Switch(
                    thumbColor: MaterialStateProperty.all(ColorManager.primary),
                    activeTrackColor: ColorManager.primary.withOpacity(.5),
                    value: planetModel.pump_watering,
                    onChanged: (bool value) {
                      isPumpOn = value;
                      planetModel.pump_watering=isPumpOn;
                      pumpState(() {});
                      plantController.updatePlanetModel2(context, planetModel: planetModel);
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
                        value:
                            '${planetModel.temperature.degree ?? planetModel.temperature.minimum ?? 0} inch' //'10',
                        )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                DetailsButton(
                  icon: Icons.add,
                  onPressed: () {
                    if (planetModel.temperature.maximum == null ||
                        (planetModel.temperature.degree ??
                                planetModel.temperature.minimum ??
                                0) <
                            (planetModel.temperature.maximum!))
                      {
                      planetModel.temperature.degree =
                          (planetModel.temperature.degree ??
                                  planetModel.temperature.minimum ??
                                  0) +
                              1;
                      plantController.updatePlanetModel2(context, planetModel: planetModel);
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
                    if (planetModel.temperature.minimum == null ||
                        (planetModel.temperature.degree ??
                                planetModel.temperature.minimum ??
                                0) >
                            (planetModel.temperature.minimum!))
                    {  planetModel.temperature.degree =
                          (planetModel.temperature.degree ??
                                  planetModel.temperature.minimum ??
                                  0) -
                              1;
                    plantController.updatePlanetModel2(context, planetModel: planetModel);
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
            Text(
              arguments['details']['soil'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: DetailsContainer(
                        value:
                            '${planetModel.soil_ph.degree ?? planetModel.soil_ph.minimum ?? 0} inch' //'10',
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
                            (planetModel.soil_ph.maximum!))
                     { planetModel.soil_ph.degree =
                          (planetModel.soil_ph.degree ??
                                  planetModel.soil_ph.minimum ??
                                  0) +
                              1;
                     plantController.updatePlanetModel2(context, planetModel: planetModel);
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
                            (planetModel.soil_ph.minimum!))
                     { planetModel.soil_ph.degree =
                          (planetModel.soil_ph.degree ??
                                  planetModel.soil_ph.minimum ??
                                  0) -
                              1;
                     plantController.updatePlanetModel2(context, planetModel: planetModel);
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
            Text(
              arguments['details']['repeat'],
              style: StylesManager.titleBoldTextStyle(
                size: 20.sp,
              ),
            ),
            DropdownButtonFormField(
                value: planetModel.repeat_watering,
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
                items: PlantController(context: context)
                    .getListRepeat()
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            'Every ${convertMinutesToTime(e)}',
                            style: StylesManager.titleBoldTextStyle(
                                size: 20.sp, color: ColorManager.primary),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  planetModel.repeat_watering =value;
                  plantController.updatePlanetModel2(context, planetModel: planetModel);
                }),

            const Spacer(),
            ButtonApp(
              onPressed: () {
                PlantController(context: context)
                    .updatePlanetModel(context, planetModel: planetModel);

              },
              text: AppString.apply,
              backgroundColor: ColorManager.secondary,
              textColor: ColorManager.primary,
            )
          ],
        ),
      );})),
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
          borderRadius: BorderRadius.circular(8.r),
        ),
        minimumSize: Size(50.w, 50.w),
        backgroundColor: ColorManager.secondary,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: ColorManager.primary,
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
          size: 20.sp, color: ColorManager.primary),
      textAlign: TextAlign.center,
      controller: TextEditingController(text: value),
      onTap: null,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppSize.s12),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: ColorManager.secondary),
    );
  }
}
