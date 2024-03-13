
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.addScheduleRoute);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('All Schedule'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ScheduleWidget(),
        itemCount: 3,
      ),
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p8),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            boxShadow: [
              BoxShadow(
                color: ColorManager.white.withOpacity(.2),
                blurRadius: 12.0,
              )
            ],
            gradient: LinearGradient(colors: [
              ColorManager.secondary,
              ColorManager.white,
              ColorManager.primary.withOpacity(.1),
            ], stops: [
              0.0,
              1.0,
              0.6
            ])),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(AppPadding.p12),
                decoration: BoxDecoration(color: ColorManager.primary),
                child: Image.asset(
                  AssetsManager.waterDropIMG,
                  width: 36.w,
                  height: 36.w,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    'Day Name',
                    style: StylesManager.titleBoldTextStyle(
                        size: 20.sp,
                        color: ColorManager.black
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      ///Delete Schedule
                    },
                    icon: Icon(Icons.delete,color: ColorManager.error,),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p10
                    ),
                    child: Text(
                        '${"16:24"} AM - ${"18:35"}PM',
                    style: StylesManager.titleNormalTextStyle(
                      size: 16.sp,
                      color: ColorManager.primary
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
