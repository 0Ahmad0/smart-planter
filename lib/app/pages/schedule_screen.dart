
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/controller/provider/schedule_provider.dart';
import 'package:smart_plans/app/controller/schedule_controller.dart';
import 'package:smart_plans/app/models/schedule_model.dart';
import 'package:smart_plans/core/route/app_route.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../../core/utils/app_constant.dart';
import '../controller/utils/firebase.dart';
import '../widgets/constans.dart';
import '../widgets/empty_plants_widget.dart';
import '../widgets/empty_schedules_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var getSchedulesReal;
  late ScheduleController scheduleController;
  getSchedulesFun()  {
    getSchedulesReal  = FirebaseFun.database.child(AppConstants.collectionSchedule).onValue;
    return getSchedulesReal;
  }
  @override
  void initState() {
    scheduleController=ScheduleController(context: context);
    getSchedulesFun();
    super.initState();
  }
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
      body:
      StreamBuilder<DatabaseEvent>(
        stream: getSchedulesReal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Const.SHOWLOADINGINDECATOR();
          } else{ if (snapshot.connectionState == ConnectionState.active) {
            List<ScheduleModel> schedules=[];
            if (snapshot.hasData) {
              Const.SHOWLOADINGINDECATOR();
              if ((snapshot.data?.snapshot.children.length??0)>0) {
                //schedules= ScheduleModels.fromJson(snapshot.data!.snapshot.children.toList()).listScheduleModel;
              }
            }
            return

              ChangeNotifierProvider<ScheduleModelProvider>.value(
                  value: Provider.of<ScheduleModelProvider>(context),
                  child: Consumer<ScheduleModelProvider>(
                      builder: (context, planetModelProvider, child) =>
                      schedules.isNotEmpty?

                      ListView.builder(
                        itemBuilder: (context, index) => ScheduleWidget(scheduleModel:schedules[index]),
                        itemCount: schedules.length,
                      )
                          : EmptySchedulesWidget()));
          }
         else{
           return Center(child: Text('Error'));
          }
          }
        })


    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key, required this.scheduleModel});
  final ScheduleModel scheduleModel;
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
                   // scheduleModel.dayName,
                    style: StylesManager.titleBoldTextStyle(
                        size: 20.sp,
                        color: ColorManager.black
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      ScheduleController(context: context).deleteScheduleModel(context, scheduleModel: scheduleModel);
                      ///Delete Schedule
                    },
                    icon: Icon(Icons.delete,color: ColorManager.error,),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p10
                    ),
                    child: Text(
                      //'${scheduleModel.timeAm}'+'${(scheduleModel.timePm!=null)?' - ${scheduleModel.timePm}':''}',
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
