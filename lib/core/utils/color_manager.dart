import 'package:flutter/material.dart';

class ColorManager {
  ///=========> Default Colors
  // static const primary = Color(0xff2D6A4F); default
  // static const secondary = Color(0xffF2E8CF); default
  /// # ==> 0xFF(6 digets) 000000
  // static const primary = Color(0xff98B8E1); one
  ///==========>One
  // static const primary = Color(0xff6377B6); /// Prefer One Color
  // static const secondary = Color(0xffCDE7DE); /// Prefer One Color
  ///==========>Two
  // static const primary = Color(0xff57855E); /// Prefer Two Color
  // static const secondary = Color(0xffF7E650); /// Prefer Two Color
  ///==========>Three
  static const primary = Color(0xff6D9773);

  /// Prefer Two Color
  static const secondary = Color(0xff0C3B2E);

  /// Prefer Two Color
  ///
  ///
  //-- Gradient Color
  static const gradientColor1 = Color(0xff019B77);
  static const gradientColor2 = Color(0xff0DBB64);
  static const List<Color> gradientColors = [gradientColor1, gradientColor2];

  ///

  ///
  static const textFieldColor = Color(0xffD9D9D9);
  static const textFieldHintColor = Color(0xffB9B9B9);
  static const facebookButtonColor = Color(0xff4C8ECC);
  static const appBarColor = Color(0xff212A34);
  static const progressColor = Color(0xffAFD056);
  static const orangeColor = Color(0xffFFBA00);
  static const brownColor = Color(0xffBB8A52);

  ///--- Neutral
  static const black = Color(0xff13181E);
  static const white = Color(0xffFFFFFF);
  static const grey = Colors.grey;

  // static const darkGrey = Color(0xff827D89);
  // static const lightGrey = Color(0xffEFEEF0);

  ///--- Success
  static const success = Color(0xff16FACD);

  // static const successDark = Color(0xff1F7F40);
  // static const successLight = Color(0xffDAF6E4);
  ///--- Error
  static const error = Color(0xffCC4C4C);

  // static const errorDark = Color(0xff5A1623);
  // static const errorLight = Color(0xffF7DEE3);
  ///--- Warning
  static const warning = Color(0xffF8C715);
  static const warningDark = Color(0xff725A03);
  static const warningLight = Color(0xffFDEBAB);
}
