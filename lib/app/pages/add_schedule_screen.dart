import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_plans/app/widgets/button_app.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/theme_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';
import 'package:numberpicker/numberpicker.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final List<String> _weeksName = [
    'Friday',
    'Monday',
    'Saturday',
    'Sunday',
    'Thursday',
    'Tuesday',
    'Wednesday'
  ];
  int _currentIndex = 0;
  final amTimeController = TextEditingController();
  final pmTimeController = TextEditingController();
  final intervalTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amTimeController.dispose();
    pmTimeController.dispose();
    intervalTimeController.dispose();
    super.dispose();
  }

  int _currentValue = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Schedule'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s10,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Text(
              'Pick Day : ',
              style: StylesManager.titleBoldTextStyle(
                size: 24.sp,
              ),
            ),
          ),
          //ToDo : New Code
          StatefulBuilder(builder: (context, daySetState) {
            return SizedBox(
              height: 80.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                        //ToDo : New Code
                        /// check Day Is Before Selected
                        onTap: false
                            ? null
                            : () {
                                daySetState(() {
                                  _currentIndex = index;
                                });
                              },
                        child: DayWidget(
                          isSelected: _currentIndex == index,
                          day: _weeksName[index],
                        ),
                      ),
                  itemCount: _weeksName.length),
            );
          }),
          const Spacer(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: TextFiledApp(
                iconDataImage: AssetsManager.clockIMG,
                hintText: 'Am Time',
                onTap: () async {
                  showModalBottomSheet(
                      showDragHandle: true,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24))),
                      context: context,
                      builder: (_) {
                        return StatefulBuilder(
                            builder: (context, timeSetState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TimePickerSpinner(
                                    is24HourMode: true,
                                    normalTextStyle: TextStyle(
                                        fontSize: 20.sp,
                                        color:
                                        ColorManager.primary.withOpacity(.75)),
                                    highlightedTextStyle: TextStyle(
                                        fontSize: 24.sp,
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.bold),
                                    spacing: 40,
                                    isForce2Digits: true,
                                    onTimeChange: (time) {
                                      timeSetState(() {
                                        amTimeController.text =
                                            DateFormat().add_jm().format(time);
                                      });
                                    },
                                  ),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          minimumSize: Size(double.infinity, 50.0)
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Pick",
                                        style:
                                        TextStyle(color: ColorManager.primary),
                                      )),
                                ],
                              );
                            });
                      });
                },
                readOnly: true,
                controller: amTimeController,
              ),
            ),
          ),
          Theme(
            data: ThemeManager.myTheme.copyWith(
              dividerColor: Colors.transparent,
            ),
            child: Container(
              margin: EdgeInsets.all(AppMargin.m12),
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(.5),
                borderRadius: BorderRadius.circular(8)
              ),
              child: ExpansionTile(
                title: Text('Show More',style: TextStyle(
                  color: ColorManager.primary
                ),),
                children: [

                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: TextFiledApp(
                      iconDataImage: AssetsManager.clockIMG,
                      hintText: 'Pm Time',
                      onTap: () async {
                        showModalBottomSheet(
                            showDragHandle: true,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24))),
                            context: context,
                            builder: (_) {
                              return StatefulBuilder(
                                  builder: (context, timeSetState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TimePickerSpinner(
                                          is24HourMode: true,
                                          normalTextStyle: TextStyle(
                                              fontSize: 20.sp,
                                              color:
                                              ColorManager.primary.withOpacity(.75)),
                                          highlightedTextStyle: TextStyle(
                                              fontSize: 24.sp,
                                              color: ColorManager.primary,
                                              fontWeight: FontWeight.bold),
                                          spacing: 40,
                                          isForce2Digits: true,
                                          onTimeChange: (time) {
                                            timeSetState(() {
                                              pmTimeController.text =
                                                  DateFormat().add_jm().format(time);
                                            });
                                          },
                                        ),
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                minimumSize: Size(double.infinity, 50.0)
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Pick",
                                              style:
                                              TextStyle(color: ColorManager.primary),
                                            )),
                                      ],
                                    );
                                  });
                            });
                      },

                      readOnly: true,
                      controller: pmTimeController,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: TextFiledApp(
                      iconDataImage: AssetsManager.clockIMG,
                      hintText: 'interval Time',
                      onTap: () async {
                        showModalBottomSheet(
                            showDragHandle: true,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24))),
                            context: context,
                            builder: (_) {
                              return StatefulBuilder(
                                  builder: (context, timeSetState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        NumberPicker(
                                          decoration: BoxDecoration(
                                            color: ColorManager.primary.withOpacity(.2),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          textStyle: StylesManager.titleBoldTextStyle(
                                              size: 20.sp
                                          ),
                                          selectedTextStyle: StylesManager.titleBoldTextStyle(
                                              color: ColorManager.primary,
                                              size: 24.sp
                                          ),
                                          value: _currentValue,
                                          minValue: 0,
                                          step: 1,
                                          infiniteLoop: true,
                                          maxValue: 60,
                                          haptics: true,
                                          onChanged: (value) => timeSetState(() {
                                            _currentValue = value;
                                            intervalTimeController.text = value.toString()+ " time";
                                          }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(AppPadding.p8),
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  minimumSize: Size(double.infinity, 50.0)
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Pick",
                                                style:
                                                TextStyle(color: ColorManager.primary),
                                              )),
                                        )
                                      ],
                                    );
                                  });
                            });
                      },

                      readOnly: true,
                      controller: intervalTimeController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: ButtonApp(
              text: 'Add',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.back();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  const DayWidget({super.key, required this.isSelected, required this.day});

  final bool isSelected;
  final String day;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isSelected ? 100.w : 80.w,
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.all(AppPadding.p10),
      margin: EdgeInsets.symmetric(
          vertical: AppMargin.m10, horizontal: AppMargin.m10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? ColorManager.secondary
              : ColorManager.secondary.withOpacity(.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              getAbbreviatedDayName(day),
              style: StylesManager.titleBoldTextStyle(
                  color:
                      isSelected ? ColorManager.black : ColorManager.secondary,
                  size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}

String getAbbreviatedDayName(String fullName) {
  switch (fullName) {
    case 'Monday':
      return 'MON';
    case 'Tuesday':
      return 'TUE';
    case 'Wednesday':
      return 'WED';
    case 'Thursday':
      return 'THU';
    case 'Friday':
      return 'FRI';
    case 'Saturday':
      return 'SAT';
    case 'Sunday':
      return 'SUN';
    default:
      return '';
  }
}
