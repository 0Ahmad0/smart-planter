import 'package:flutter/material.dart';
import 'package:smart_plans/core/utils/app_string.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.userProfile),
      ),
    );
  }
}
