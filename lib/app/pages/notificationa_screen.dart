import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/models/notification_model.dart';
import '../../core/utils/app_constant.dart';
import '../controller/provider/notification_provider.dart';
import '../controller/provider/profile_provider.dart';
import '../controller/splashController.dart';
import '../widgets/constans.dart';
import '/core/utils/app_string.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/styles_manager.dart';
import '/core/utils/values_manager.dart';

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

  var getNotifications;
  late NotificationProvider notificationProvider;
  getNotificationsFun()  {
    String idUser=context.read<ProfileProvider>().user.id;
    getNotifications = FirebaseFirestore.instance.collection(AppConstants.collectionNotification)
        .where('idUser',isEqualTo:idUser).snapshots();
    return getNotifications;
  }
  @override
  void initState() {
    notificationProvider=  Provider.of<NotificationProvider>(context,listen: false);;
    getNotificationsFun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.notifications),
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        //prints the messages to the screen0
          stream: getNotifications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Const.SHOWLOADINGINDECATOR();
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                Const.SHOWLOADINGINDECATOR();
                notificationProvider.notifications.listNotificationModel.clear();
                if (snapshot.data!.docs!.length > 0) {
                  notificationProvider.notifications = NotificationModels.fromJson(snapshot.data!.docs!);
                }
                List<NotificationModel> listNotifications=notificationProvider.notifications.listNotificationModel;
                return
                  listNotifications.isEmpty?
                  Const.emptyWidget(context,text: "No Notification Yet")
                      :
                  ListView.builder(
                      itemCount:listNotifications.length,
                      itemBuilder: (_, index) {
                        bool isSameDate = true;
                        final String dateString = list[0]['time'];
                        final DateTime date = listNotifications[index].dateTime;//DateTime.parse(dateString);
                        final item = listNotifications[index];
                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          //final String prevDateString = list[index - 1]['time'];
                          final DateTime prevDate = listNotifications[index-1].dateTime; //DateTime.parse(prevDateString);
                          isSameDate = date.isSameDate(prevDate);
                        }
                        if (index == 0 || !(isSameDate)) {
                          return NotificationWidget(date: date,index: index,notificationModel: item,);
                        } else {
                          return NotificationItem(index: index, notificationModel: item,);
                        }
                      })
                ;
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          })
      ,
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key, required this.index,
    required this.notificationModel,
  });

  final int index;
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        notificationModel.checkRec=true;
        context.read<NotificationProvider>().updateNotification(context, notification: notificationModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppMargin.m14, vertical: AppMargin.m4),
        decoration: BoxDecoration(
          color: !notificationModel.checkRec
              ?ColorManager.secondary:ColorManager.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: ListTile(
          title: Text(
            notificationModel.title+' $index',
            style: StylesManager.titleBoldTextStyle(
              size: 20.sp,
              color: ColorManager.primary,
            ),
          ),
          subtitle: Text(
            notificationModel.subtitle,
            style: TextStyle().copyWith(color: ColorManager.black),
          ),
          trailing: Icon(!notificationModel.checkRec?null:Icons.check),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.date, required this.index, required this.notificationModel,
  });

  final DateTime date;
  final int index;
  final NotificationModel notificationModel;

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
          NotificationItem(index: index,notificationModel: notificationModel,)
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
