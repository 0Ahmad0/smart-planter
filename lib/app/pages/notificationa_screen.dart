import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map> list = [
    {
      "time": "2020-06-16T10:31:12.000Z",
      "message":
          "P2 BGM-01 HV buiten materieel (Gas lekkage) Franckstraat Arnhem 073631"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "message": "A1 Brahmslaan 3862TD Nijkerk 73278"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "message": "A2 NS Station Rheden Dr. Langemijerweg 6991EV Rheden 73286"
    },
    {
      "time": "2020-06-15T09:41:18.000Z",
      "message": "A2 VWS Utrechtseweg 6871DR Renkum 74636"
    },
    {
      "time": "2020-06-14T09:40:58.000Z",
      "message":
          "B2 5623EJ : Michelangelolaan Eindhoven Obj: ziekenhuizen 8610 Ca CATH route 522 PAAZ Rit: 66570"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.notifications),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            bool isSameDate = true;
            final String dateString = list[index]['time'];
            final DateTime date = DateTime.parse(dateString);
            final item = list[index];
            if (index == 0) {
              isSameDate = false;
            } else {
              final String prevDateString = list[index - 1]['time'];
              final DateTime prevDate = DateTime.parse(prevDateString);
              isSameDate = date.isSameDate(prevDate);
            }
            if (index == 0 || !(isSameDate)) {
              return NotificationWidget(date: date,index: index,);
            } else {
              return NotificationItem(index: index,);
            }
          }),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key, required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppMargin.m14, vertical: AppMargin.m4),
      decoration: BoxDecoration(
        color: index.isEven?ColorManager.secondary:ColorManager.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ListTile(
        title: Text(
          'item $index',
          style: StylesManager.titleBoldTextStyle(
            size: 20.sp,
            color: ColorManager.primary,
          ),
        ),
        subtitle: Text(
          'item $index item item item item item item',
          style: TextStyle().copyWith(color: ColorManager.black),
        ),
        trailing: Icon(index.isEven?null:Icons.check),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.date, required this.index,
  });

  final DateTime date;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: AppMargin.m8,top: AppMargin.m10,bottom:AppMargin.m8 ),

                child: Text(
                  date.formatDate(),
                  style: StylesManager.titleNormalTextStyle(
                    size: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.white,))
            ],
          ),
          NotificationItem(index: index,)
        ]);
  }
}

///

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
