import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';

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
                  onPressed: () {},
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
            text: 'Connection',
            icon: Icons.wifi,
          ),
          Divider(),
          ListTileDrawerItem(
            text: 'Connection',
            icon: Icons.wifi,
          ),
          const Spacer(),
          ListTileDrawerItem(
            text: 'Log out',
            icon: Icons.logout,
          )
        ],
      ),
    );
  }
}

class ListTileDrawerItem extends StatelessWidget {
  const ListTileDrawerItem({
    super.key, required this.text, required this.icon,  this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        text,
        style: StylesManager.titleNormalTextStyle(
          color: ColorManager.black,
          size: 18.sp
        ),
      ),
    );
  }
}
