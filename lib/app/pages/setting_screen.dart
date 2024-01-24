import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../controller/auth_controller.dart';
import '../controller/provider/profile_provider.dart';
import '../widgets/button_app.dart';
import '../widgets/constans.dart';

class SettingScreen extends StatefulWidget {
   SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController passwordController=TextEditingController(text:  '');

  late AuthController authController;

  @override
  void initState() {
    authController = AuthController(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.userProfile),
      ),
      body:
      ChangeNotifierProvider<ProfileProvider>.value(
        value: Provider.of<ProfileProvider>(context),
        child:
        Consumer<ProfileProvider>(builder: (context, value, child){
          passwordController=TextEditingController(text:  '${value.user.password}');
     return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                const SizedBox(height: AppSize.s20,),
                TextFiledApp(
                  controller:value.name, //TextEditingController(text:   '${value.user.name}',),
                  iconData: Icons.person_outline,
                ),
                const SizedBox(height: AppSize.s20,),

                TextFiledApp(
                  controller: value.email,//TextEditingController(text:   '${value.user.name}',),
                  iconData: Icons.alternate_email,
                ),
                const SizedBox(height: AppSize.s20,),
                TextFiledApp(
                  suffixIcon: true,
                  obscureText: true,
                  controller: passwordController,
                  iconData: Icons.lock_outline,
                ),
                const SizedBox(height: AppSize.s100,),

                ButtonApp(
                  text: AppString.update,
                  onPressed: () async {

                      Const.loading(context);
                      await value.editUser(context);
                      await authController.recoveryPassword(context, password: passwordController.value.text);
                      Navigator.of(context).pop();

                  },
                ),
              ],
            ),
          ),
        ),
      );})),
    );

  }
}
