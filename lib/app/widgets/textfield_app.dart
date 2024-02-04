import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/utils/app_string.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';

class TextFiledApp extends StatefulWidget {
  TextFiledApp(
      {Key? key,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.iconData,
      this.hintText,
      this.obscureText = false,
      this.suffixIcon = false,
      this.validator,
      this.onChanged,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false,
      this.maxLine = 1,
      this.minLine = 1})
      : super(key: key);

  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? iconData;
  final String? hintText;
  final bool suffixIcon;
  final bool autofocus;
  final bool readOnly;
  bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final int? maxLine;
  final int? minLine;

  @override
  State<TextFiledApp> createState() => _TextFiledAppState();
}

class _TextFiledAppState extends State<TextFiledApp> {
  void showPassword() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      validator: widget.validator ??
          (String? val) {
            if (val!.trim().isEmpty) return AppString.requiredFiled;
            return null;
          },
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      cursorColor: ColorManager.secondary,
      decoration: InputDecoration(
        border: StylesManager.borderTextFiled(),
        focusedErrorBorder: StylesManager.borderTextFiled(
            color: ColorManager.secondary, width: 4),
        errorBorder: StylesManager.borderTextFiled(
            color: ColorManager.secondary, width: 4),
        enabledBorder: StylesManager.borderTextFiled(),
        focusedBorder: StylesManager.borderTextFiled(width: 4),
        hintStyle: TextStyle(color: ColorManager.secondary.withOpacity(.75)),
        errorStyle: TextStyle(color: ColorManager.secondary),
        errorMaxLines: 2,
        prefixIcon: widget.iconData == null
            ? null
            : Icon(
                widget.iconData,
                size: 24.sp,
              ),
        suffixIcon: widget.suffixIcon
            ? IconButton(
                onPressed: () {
                  showPassword();
                },
                icon: Icon(
                  widget.obscureText
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye,
                  color: !widget.obscureText
                      ? ColorManager.secondary
                      : ColorManager.secondary.withOpacity(.2),
                ))
            : null,
        hintText: widget.hintText,
      ),
    );
  }
}
