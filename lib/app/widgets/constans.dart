import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/values_manager.dart';
import '/core/utils/color_manager.dart';
import '../../core/utils/assets_manager.dart';
import '../models/enums/state_stream_enum.dart';

class Const {
  static loading(context) {
    Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future(() => true);
        },
        child: Center(
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
      ),
      barrierDismissible: false,
    );
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

  static TOAST(
    BuildContext context, {
    String textToast = "This Is Toast",
    backgroundColor = ColorManager.black,
  }) {
    showToastWidget(
        Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  textToast,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: AppSize.s10,
              ),
              Container(
                padding: const EdgeInsets.all(AppPadding.p4),
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Image.asset(
                  AssetsManager.logoIMG,
                ),
              )
            ],
          ),
        ),
        isHideKeyboard: true,
        context: context,
        axis: Axis.horizontal,
        position: StyledToastPosition.bottom);
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
          Image.asset(
            AssetsManager.emptyIMG,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ));
}
