import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/color_manager.dart';

class PickImageBottomSheetWidget extends StatelessWidget {
  const PickImageBottomSheetWidget(
      {super.key,
      required this.cameraTap,
      required this.galleryTap,
      required this.deleteTap});

  @override
  final VoidCallback cameraTap;
  final VoidCallback galleryTap;
  final VoidCallback deleteTap;

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(onPressed: (){
          if(Navigator.canPop(context)){
            Get.back();
          }
        }, icon: Icon(Icons.close,color: ColorManager.error,)),
        PickerListTileWidget(
          title: AppString.addFromCamera,
          icon: Icons.camera_alt,
          onTap: cameraTap,
        ),
        const Divider(height: 0.0,),
        PickerListTileWidget(
          title: AppString.addFromGallery,
          icon: Icons.image_outlined,
          onTap: galleryTap,
        ),
        const Divider(height: 0.0,),
        PickerListTileWidget(
          title: AppString.deletePhoto,
          icon: Icons.delete,
          onTap: deleteTap,
          iconColor: ColorManager.error,
          textColor: ColorManager.error,
        ),
      ],
    );
  }
}

class PickerListTileWidget extends StatelessWidget {
  const PickerListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = ColorManager.primary,
    this.textColor = ColorManager.primary,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
