import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/helper/convert_to_material_color.dart';
import 'color_manager.dart';

class ThemeManager {
  static ThemeData myTheme = ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: ColorManager.secondary,
              ),
          primarySwatch: Color(
            ColorManager.primary.value,
          ).toMaterialColor(),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: ColorManager.secondary,
            foregroundColor: ColorManager.primary,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: ColorManager.appBarColor,
            iconTheme: IconThemeData(
              color: ColorManager.primary,
            ),
            elevation: 0.0,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
                fontSize: 24.sp),
          ),
          listTileTheme: ListTileThemeData(
              titleTextStyle: TextStyle(color: ColorManager.white)),
          drawerTheme: DrawerThemeData(backgroundColor: ColorManager.secondary))
      .copyWith(
          textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          scaffoldBackgroundColor: Colors.transparent,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.white,
              ));
}
