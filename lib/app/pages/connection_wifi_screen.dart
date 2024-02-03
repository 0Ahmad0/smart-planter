import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/app_constant.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../controller/controller.dart';
import '../controller/plant_controller.dart';

class ConnectionWifiScreen extends StatefulWidget {
  const ConnectionWifiScreen({super.key});

  @override
  State<ConnectionWifiScreen> createState() => _ConnectionWifiScreenState();
}

class _ConnectionWifiScreenState extends State<ConnectionWifiScreen> {
  late PlantController plantController;

  @override
  void initState() {
    plantController = PlantController(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ListController listPlant = Get.put(ListController());
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.connectionWifi),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            WifiConnectingWidget(
              wifiName: 'Wifi-1',
              onTap: () {
                plantController.getPlants(context);
                // Get.dialog(Center(
                //   child: Container(width: 80,height: 80,decoration: BoxDecoration(
                //     color: ColorManager.white,
                //     borderRadius: BorderRadius.circular(8.r)
                //
                //   ),child: Center(child: CircularProgressIndicator()),),
                // ),);
                //
                // Future.delayed(Duration(seconds: 2),(){
                //   listPlant.addTemp();
                //   Get.back();
                //   Get.offAllNamed(AppRoute.homeRoute);
                // });
              },
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            IgnorePointer(
              ignoring: true,
              child: WifiConnectingWidget(
                wifiName: 'Wifi-2',
                onTap: null,
                active: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WifiConnectingWidget extends StatelessWidget {
  const WifiConnectingWidget({
    super.key,
    required this.wifiName,
    required this.onTap,
    this.active = true,
  });

  final String wifiName;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: active?ColorManager.secondary:ColorManager.grey,
          borderRadius: BorderRadius.circular(8.r)),
      child: ListTile(
        onTap: onTap,
        title: Text(
          wifiName,
          style: StylesManager.titleNormalTextStyle(
              size: 20.sp, color: ColorManager.primary),
        ),
        subtitle: Text(
          '192.186.12.0',
          style: TextStyle(color: ColorManager.black),
        ),
        trailing: CircleAvatar(
            child: Icon(
              active?Icons.wifi_outlined:Icons.wifi_off_outlined,
            ))
      ),
    );
  }
}
