import 'package:flutter/material.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.userProfile),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                const SizedBox(height: AppSize.s20,),
                TextFiledApp(
                  controller: TextEditingController(text: 'Nada'),
                  iconData: Icons.person_outline,
                ),
                const SizedBox(height: AppSize.s20,),

                TextFiledApp(
                  controller: TextEditingController(text: 'nada@gmail.com',),
                  iconData: Icons.alternate_email,
                ),
                const SizedBox(height: AppSize.s20,),
                TextFiledApp(
                  suffixIcon: true,
                  obscureText: true,
                  controller: TextEditingController(text: '12345678'),
                  iconData: Icons.lock_outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
