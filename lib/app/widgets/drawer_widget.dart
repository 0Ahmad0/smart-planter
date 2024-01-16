import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';

import 'list_tile_drawer_item.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('User'),
            accountEmail: Text('user@gmail.com'),
            otherAccountsPictures: [
              IconButton(
                  onPressed: () {
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
          ),
          ListTileDrawerItem(
            text: AppString.connectionWifi,
            icon: Icons.wifi,
            onTap: (){
              Get.back();
              Get.toNamed(AppRoute.connectionWifiRoute);
            },
          ),
          Divider(),
          ListTileDrawerItem(
            text: AppString.setting,
            icon: Icons.settings,
            onTap: (){
              Get.back();
              Get.toNamed(AppRoute.settingRoute);
            },
          ),
          Divider(),
          ListTileDrawerItem(
            text: AppString.notifications,
            icon: Icons.notifications,
            trailing: Badge(
              backgroundColor: ColorManager.primary,
              smallSize: 24.sp,
              largeSize: 30.sp,
              label: Text('100'),
            ),
            onTap: (){
              Get.back();
              Get.toNamed(AppRoute.notificationRoute);
            },
          ),
          const Spacer(),
          ListTileDrawerItem(
            text: 'Log out',
            icon: Icons.logout,
            onTap: (){
              Get.back();
              Get.offAllNamed(AppRoute.loginRoute);
            },
          )
        ],
      ),
    );
  }
}

