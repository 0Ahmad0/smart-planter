import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_plans/core/utils/color_manager.dart';

import '../../core/utils/assets_manager.dart';
import '../models/enums/state_stream_enum.dart';

class Const {
  static loading(context) {
    Get.dialog(
      Center(
        child: Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(.2),
                  offset: const Offset(0, 4),
                  blurRadius: 8.sp,
                )
              ]),
          child: Center(
              child: Lottie.asset(
            AssetsManager.loadingIMG,
          )),
        ),
      ),
      barrierDismissible: false,


    );
    // Get.dialog(
    //     Center(
    //       child: Container(
    //           alignment: Alignment.center,
    //           width:  MediaQuery.sizeOf(context).width  * 0.2,
    //           height: MediaQuery.sizeOf(context).width * 0.2,
    //           decoration: BoxDecoration(
    //               color: ColorManager.white,
    //               borderRadius: BorderRadius.circular(8)),
    //           child:
    //           CircularProgressIndicator(
    //             color: ColorManager.primary,
    //           )
    //       ),
    //     ),
    //     barrierDismissible: false
    // );
  }

  static LOADING_DROPDOWN(
      {required String text, StateStreamEnum? stateStream}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      trailing: stateStream == StateStreamEnum.Empty
          ? Icon(Icons.hourglass_empty_outlined)
          : stateStream == StateStreamEnum.Error
              ? Icon(Icons.error_outline)
              : CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
    );
  }

  static TOAST(BuildContext context, {String textToast = "This Is Toast"}) {
    // showToast(
    //     textToast,
    //     context: context,
    //     animation: StyledToastAnimation.fadeScale,
    //     position: StyledToastPosition.top,
    //     textStyle: getRegularStyle(color: ColorManager.white)
    // );
  }

  static SHOWLOADINGINDECATOR() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static emptyWidget(context, {text = 'Not Data Yet!'}) =>
      SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.emptyIMG),
          Text(
            text,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.bold),
          ),
        ],
      ));
}
