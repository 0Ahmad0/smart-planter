import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_plans/app/widgets/button_app.dart';
import 'package:smart_plans/app/widgets/textfield_app.dart';
import 'package:smart_plans/core/helper/sizer_media_query.dart';
import 'package:smart_plans/core/utils/app_string.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';
import 'package:smart_plans/core/utils/values_manager.dart';

import '../widgets/pick_image_bottom_sheet_widget.dart';

class AddNewPlantScreen extends StatefulWidget {
  const AddNewPlantScreen({super.key});

  @override
  State<AddNewPlantScreen> createState() => _AddNewPlantScreenState();
}

class _AddNewPlantScreenState extends State<AddNewPlantScreen> {
  late final ImagePicker imagePicker;
  XFile? _image;

  final _formKey = GlobalKey<FormState>();

  void _deleteImage() {
    _image = null;
    setState(() {});
    if (Navigator.canPop(context)) {
      Get.back();
    }
  }

  Future<void> _pickImage({required ImageSource source}) async {
    final image = await imagePicker.pickImage(source: source);
    if (image != null) {
      _image = image;
      setState(() {});
      Get.back();
    }
  }

  final numberRegExp = RegExp('');

  @override
  void initState() {
    imagePicker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addNewPlant),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: getWidth(context) / 2,
                    decoration: BoxDecoration(
                        color: ColorManager.secondary,
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.black.withOpacity(.5),
                              blurRadius: AppSize.s8)
                        ],
                        borderRadius: BorderRadius.circular(12)),
                    child: _image != null
                        ? InkWell(
                            onTap: () {},
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: getWidth(context) / 2,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                isDismissible: false,
                                clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(14.0)),
                                  ),
                                  context: context,
                                  builder: (_) => PickImageBottomSheetWidget(
                                        cameraTap: () {
                                          _pickImage(
                                              source: ImageSource.camera);
                                        },
                                        galleryTap: () {
                                          _pickImage(
                                              source: ImageSource.gallery);
                                        },
                                        deleteTap: () {
                                          _deleteImage();
                                        },
                                      ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetsManager.addNewPlantIMG,
                                  width: AppSize.s100,
                                  height: AppSize.s100,
                                ),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                Text(
                                  AppString.addNewPlant,
                                  textAlign: TextAlign.center,
                                  style: StylesManager.titleNormalTextStyle(
                                      color: ColorManager.primary),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Visibility(
                    visible: _image != null,
                    child: Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(AppPadding.p10),
                        decoration: BoxDecoration(
                            color: ColorManager.secondary.withOpacity(.9),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(14.0),
                            )),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorManager.white,
                              child: IconButton(
                                onPressed: () {
                                  _deleteImage();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: ColorManager.error,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: AppSize.s10,
                            ),
                            CircleAvatar(
                              backgroundColor: ColorManager.white,
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      showDragHandle: true,
                                      isDismissible: false,
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(14.0)),
                                      ),
                                      context: context,
                                      builder: (_) =>
                                          PickImageBottomSheetWidget(
                                            cameraTap: () {
                                              _pickImage(
                                                  source: ImageSource.camera);
                                            },
                                            galleryTap: () {
                                              _pickImage(
                                                  source: ImageSource.gallery);
                                            },
                                            deleteTap: () {
                                              _deleteImage();
                                            },
                                          ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              AddPlantFormWidget(
                formKey: _formKey,
                image: _image,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddPlantFormWidget extends StatelessWidget {
  const AddPlantFormWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required XFile? image,
  })  : _formKey = formKey,
        _image = image;

  final GlobalKey<FormState> _formKey;
  final XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14),
            color: ColorManager.white.withOpacity(.2)),
        child: Column(
          children: [
            TextFiledApp(
              hintText: 'Soil Ph',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Fertilizer quantity',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Repeat fertlizing',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Water quantity',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Soil moister',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Repeat watering',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Temperature',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              hintText: 'Sunlight',
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ButtonApp(
              text: AppString.addNewPlant,
              onPressed: () {
                if (_image != null && !_formKey.currentState!.validate()) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
