import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_plans/app/controller/plant_controller.dart';
import 'package:smart_plans/app/models/planet_model.dart';
import 'package:smart_plans/app/widgets/button_app.dart';
import 'package:smart_plans/app/widgets/gradient_container_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? _image;

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

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      colors: ColorManager.gradientColors,
      child: Scaffold(
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
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
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
                                      color: ColorManager.primary,
                                    ),
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
                                                    source:
                                                        ImageSource.camera);
                                              },
                                              galleryTap: () {
                                                _pickImage(
                                                    source:
                                                        ImageSource.gallery);
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
      ),
    );
  }
}

class AddPlantFormWidget extends StatefulWidget {
  const AddPlantFormWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required XFile? image,
  })  : _formKey = formKey,
        _image = image;

  final GlobalKey<FormState> _formKey;
  final XFile? _image;

  @override
  State<AddPlantFormWidget> createState() => _AddPlantFormWidgetState();
}

class _AddPlantFormWidgetState extends State<AddPlantFormWidget> {
  ///عرفنا كونترولرات من اجل اخذ القيم من المستخدك
  final nameController = TextEditingController();
  final soilPhController = TextEditingController();
  final fertilizerQuantityController = TextEditingController();
  final repeatFertlizingController = TextEditingController();
  final waterQuantityController = TextEditingController();
  final soilMoisterController = TextEditingController();
  final repeatWateringController = TextEditingController();
  final temperatureController = TextEditingController();
  final sunlightController = TextEditingController();
  final descriptionController = TextEditingController();

  ///هنا جعلنا ال حقل بقبل فقط ارقام اي تظهر لوحة المفاتيح الخاصة بالارقام فقط
  final textInputType = TextInputType.numberWithOptions(decimal: true);

  /// هنا اضفنا reguler expretioon
  /// من اجل ان لا نسمح بكتابة غير الارقام في الحقل لانه من الممكن مثلا ان يقوم المستخدم بنسح نص ولصقه في الحقل
  /// فبدون هذه ال regular  سيقبل الحقل وهذا خطأ
  final textInputFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
  ];

  late PlantController plantController;

  @override
  void initState() {
    plantController = PlantController(context: context);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    soilPhController.dispose();
    fertilizerQuantityController.dispose();
    repeatFertlizingController.dispose();
    waterQuantityController.dispose();
    soilMoisterController.dispose();
    repeatWateringController.dispose();
    temperatureController.dispose();
    sunlightController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Container(
        padding: EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14),
            color: ColorManager.white.withOpacity(.2)),
        child: Column(
          children: [
            TextFiledApp(
              controller: nameController,
              hintText: 'Name plant',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: soilPhController,
              hintText: 'Soil Ph',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: fertilizerQuantityController,
              hintText: 'Fertilizer quantity',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: repeatFertlizingController,
              hintText: 'Repeat fertlizing',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: waterQuantityController,
              hintText: 'Water quantity',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: soilMoisterController,
              hintText: 'Soil moister',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: repeatWateringController,
              hintText: 'Repeat watering',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: temperatureController,
              hintText: 'Temperature',
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              keyboardType: textInputType,
              filteringTextFormatterList: textInputFormatter,
              controller: sunlightController,
              hintText: 'Sunlight',
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            TextFiledApp(
              controller: descriptionController,
              hintText: 'Description',
              minLine: 4,
              maxLine: 8,
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ButtonApp(
              text: AppString.addNewPlant,
              onPressed: () {
                if( widget._formKey.currentState!.validate()){
                  if (widget._image != null) {
                    plantController.addDefaultPlanet(context,
                        planetModel: PlanetModel(
                          id: 0,
                          description: descriptionController.value.text,
                          name: nameController.value.text,
                          age: 0,
                          fertilizer_quantity: QuantityModel(
                              value: double.parse(
                                  fertilizerQuantityController.value.text)
                                  .toInt(),
                              type: ''),
                          repeat_fertilizing:
                          double.parse(repeatFertlizingController.value.text),
                          repeat_watering:
                          double.parse(repeatWateringController.value.text),
                          soil_moister: MinMaxModel(
                              minimum: null,
                              maximum: null,
                              degree:
                              double.parse(soilMoisterController.value.text)),
                          soil_ph: MinMaxModel(
                              minimum: null,
                              maximum: null,
                              degree: double.parse(soilPhController.value.text)),
                          sunlight: MinMaxModel(
                              minimum: null,
                              maximum: null,
                              degree:
                              double.parse(sunlightController.value.text)),
                          temperature: MinMaxModel(
                              minimum: null,
                              maximum: null,
                              degree:
                              double.parse(temperatureController.value.text)),
                          url_image: '',
                          water_quantity: QuantityModel(
                              value:
                              double.parse(waterQuantityController.value.text)
                                  .toInt(),
                              type: ''),
                          isAdd: false,
                        ),
                        image: widget._image);
//send Date
                    //هنا بجب ارسال الداتا
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
