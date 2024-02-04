import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_constant.dart';
import '../models/notification_model.dart';
import '/core/route/app_route.dart';
import '/core/utils/app_string.dart';
import '/core/utils/color_manager.dart';

import '../../core/local/storage.dart';
import '../controller/provider/profile_provider.dart';
import 'list_tile_drawer_item.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var getNotifications;

  getNotificationsFun()  {
    String idUser=context.read<ProfileProvider>().user.id;
    getNotifications = FirebaseFirestore.instance.collection(AppConstants.collectionNotification)
        .where('idUser',isEqualTo:idUser).snapshots();
    return getNotifications;
  }
  @override
  void initState() {
  getNotificationsFun();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ChangeNotifierProvider<ProfileProvider>.value(
              value: Provider.of<ProfileProvider>(context),
              child: Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) =>
                      UserAccountsDrawerHeader(
                        accountName: Text(
                          '${profileProvider.user.name}',
                        ),
                        accountEmail: Text(
                          '${profileProvider.user.email}',
                        ),
                        otherAccountsPictures: [
                          IconButton(
                              onPressed: () async {
                                await AppStorage.depose();
                                Get.back();
                                Get.offAllNamed(AppRoute.loginRoute);
                              },
                              icon: Icon(
                                Icons.logout,
                                color: ColorManager.secondary,
                              ))
                        ],
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: ColorManager.secondary,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                        ),
                      ))),
          ListTileDrawerItem(
            text: AppString.connectionWifi,
            icon: Icons.wifi,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoute.connectionWifiRoute);
            },
          ),
          Divider(),
          ListTileDrawerItem(
            text: AppString.setting,
            icon: Icons.settings,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoute.settingRoute);
            },
          ),
          Divider(),
          ListTileDrawerItem(
            text: AppString.notifications,
            icon: Icons.notifications,
            trailing: buildCountNotifications(),
            onTap: () {
              Get.back();
              Get.toNamed(AppRoute.notificationRoute);
            },
          ),
          const Spacer(),
          ListTileDrawerItem(
            text: 'Log out',
            icon: Icons.logout,
            onTap: () async {
              await AppStorage.depose();
              Get.back();
              Get.offAllNamed(AppRoute.loginRoute);
            },
          )
        ],
      ),
    );
  }

Widget  buildCountNotifications(){
return StreamBuilder<QuerySnapshot>(

    stream: getNotifications,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return   SizedBox.shrink();
      } else if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasError) {
          return   SizedBox.shrink();
        } else if (snapshot.hasData) {

       int countUnRead=0;
          if (snapshot.data!.docs!.length > 0) {
            List<NotificationModel> listNotifications = NotificationModels.fromJson(snapshot.data!.docs!).listNotificationModel;
            for(NotificationModel notificationModel in listNotifications)
              if(!notificationModel.checkRec)
                countUnRead++;

          }
          return
            countUnRead==0?
            SizedBox.shrink()
                :
             Badge(
                backgroundColor: ColorManager.primary,
                smallSize: 24.sp,
                largeSize: 30.sp,
                label: Text('${countUnRead}'),
            );
        } else {
          return   SizedBox.shrink();
        }
      } else {
        return   SizedBox.shrink();
      }
    });
  }
}
