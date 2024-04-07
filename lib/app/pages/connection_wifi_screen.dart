import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
import '/core/utils/app_string.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/styles_manager.dart';
import '/core/utils/values_manager.dart';
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
    return GradientContainerWidget(
      colors: ColorManager.gradientColors,
      child: Scaffold(
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
