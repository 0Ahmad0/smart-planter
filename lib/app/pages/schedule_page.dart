import 'package:flutter/material.dart';
import 'package:smart_plans/core/route/app_route.dart';

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
        onPressed: (){
          Navigator.pushNamed(context, AppRoute.addScheduleRoute);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('All Schedule'),
      ),
    );
  }
}
