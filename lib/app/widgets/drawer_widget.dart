import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/auth_controller.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';

import '../../core/local/storage.dart';
import '../controller/provider/profile_provider.dart';
import 'list_tile_drawer_item.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

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
            accountName: Text(  '${profileProvider.user.name}',),
            accountEmail: Text(  '${profileProvider.user.email}',),
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
          ))),
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
}

