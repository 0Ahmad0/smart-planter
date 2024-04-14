import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';

class ListTileDrawerItem extends StatelessWidget {
  const ListTileDrawerItem({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        text,
        style: StylesManager.titleNormalTextStyle(
            color: ColorManager.white, size: 18.sp),
      ),
      trailing: trailing,
      iconColor: ColorManager.gradientColor1,
      selectedTileColor: ColorManager.gradientColor2,
    );
  }
}
