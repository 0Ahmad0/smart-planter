import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          )
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
