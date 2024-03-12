import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:smart_plans/app/widgets/button_app.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

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
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    amTimeController.dispose();
    pmTimeController.dispose();
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
        children: [
          const SizedBox(
            height: AppSize.s20,
          ),
          StatefulBuilder(
            builder: (context,daySetState) {
              return SizedBox(
                height: 80.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            daySetState((){
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
            }
          ),
          const Spacer(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: TextFiledApp(
                hintText: 'Am Time',
                onTap: ()async{
                  showModalBottomSheet(context: context, builder: (_){
                    return StatefulBuilder(
                      builder: (context,timeSetState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NumberPicker(
                              decoration: BoxDecoration(
                                color: ColorManager.primary.withOpacity(.2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              textStyle: StylesManager.titleBoldTextStyle(),
                              selectedTextStyle: StylesManager.titleBoldTextStyle(color: ColorManager.primary),
                              value: _currentValue,
                              minValue: 0,
                              step: 1,
                              maxValue: 24,
                              haptics: true,
                              onChanged: (value) => timeSetState(() {
                                _currentValue = value;
                                amTimeController.text = value.toString();
                              }),
                            ),
                          ],
                        );
                      }
                    );
                  });

                },
                readOnly: true,
                controller: amTimeController,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s20,),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: TextFiledApp(
              hintText: 'Pm Time',

              onTap: ()async{
                showModalBottomSheet(context: context, builder: (_){
                  return StatefulBuilder(
                      builder: (context,timeSetState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NumberPicker(
                              decoration: BoxDecoration(
                                color: ColorManager.primary.withOpacity(.2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              textStyle: StylesManager.titleBoldTextStyle(),
                              selectedTextStyle: StylesManager.titleBoldTextStyle(color: ColorManager.primary),
                              value: _currentValue,
                              minValue: 0,
                              step: 1,
                              maxValue: 24,
                              haptics: true,
                              onChanged: (value) => timeSetState(() {
                                _currentValue = value;
                                pmTimeController.text = value.toString();
                              }),
                            ),
                          ],
                        );
                      }
                  );
                });
              },
              readOnly: true,
              controller: pmTimeController,
            ),
          ),
          const Spacer(),
          ButtonApp(
            text: 'Add',
            onPressed: (){
              if(_formKey.currentState!.validate()){
                Get.back();
              }
            },
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
          borderRadius: BorderRadius.circular(8) ,
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
                  color: isSelected ? ColorManager.black : ColorManager.secondary, size: 20.sp),
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
