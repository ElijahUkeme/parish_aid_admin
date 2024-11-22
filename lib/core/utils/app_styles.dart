import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_dimensions.dart';
import 'color.dart';

class Fonts {
  static const String montserrat = 'Montserrat';
  static const String roboto = 'Roboto';
}

extension StyleExtension on BuildContext {
  TextStyle get toolBarTitleStyle {
    return TextStyles.h1.copyWith(
        letterSpacing: -.32,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: blackColor
    );
  }
}

class TextStyles {
  static  TextStyle montserrat = const TextStyle(
    fontFamily: Fonts.montserrat,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle roboto = TextStyle(
    fontFamily: Fonts.roboto,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle get appTitle => _createTextStyle(
    style: montserrat,
    weight: FontWeight.w900,
    fontSize: FontSizes.s36,
  );

  static TextStyle get appTitle1 => _createTextStyle(
    style: montserrat,
    weight: FontWeight.bold,
    fontSize: FontSizes.s20,
    height: .5,
  );

  static TextStyle get t1 => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s20,
    weight: FontWeight.w600,
    letterSpacing: -.32,
  );

  static TextStyle get t2 => _createTextStyle(
    style: montserrat,
    weight: FontWeight.w500,
    fontSize: FontSizes.s16,
    letterSpacing: -.32,
  );

  static TextStyle get t3 => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s14,
    weight: FontWeight.w500,
    letterSpacing: -.5,
  );

  static TextStyle get h1 => _createTextStyle(
    style: montserrat,
    weight: FontWeight.w500,
    fontSize: FontSizes.s28,
  );

  static TextStyle get h2 => _createTextStyle(
    style: montserrat,
    weight: FontWeight.w500,
    fontSize: FontSizes.s16,
  );

  static TextStyle get h3 => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s18,
    letterSpacing: -.32,
  );

  static TextStyle get h4 => _createTextStyle(
    style: montserrat,
    letterSpacing: -.32,
    weight: FontWeight.w500,
    fontSize: FontSizes.s16,
  );

  static TextStyle get h5 => _createTextStyle(
    style: montserrat,
    letterSpacing: -.32,
    weight: FontWeight.w500,
    fontSize: FontSizes.s14,
  );

  static TextStyle get body1 => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s14,
    letterSpacing: -.32,
  );

  static TextStyle get body2 => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s12,
    letterSpacing: -.32,
  );

  static TextStyle get body3 => _createTextStyle(
      style: montserrat,
      fontSize: FontSizes.s11,
      letterSpacing: -.32,
      height: 1.5);

  static TextStyle get callout => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s14,
    letterSpacing: 1.75,
  );

  static TextStyle get calloutFocus => _createTextStyle(
    style: callout,
    weight: FontWeight.bold,
    fontSize: FontSizes.s14,
  );

  static TextStyle get btnStyle => _createTextStyle(
    style: montserrat,
    weight: FontWeight.w400,
    fontSize: FontSizes.s14,
  );

  static TextStyle get caption => _createTextStyle(
    style: montserrat,
    fontSize: FontSizes.s14,
    weight: FontWeight.w300,
    letterSpacing: .3,
  );

  static TextStyle _createTextStyle({
    required TextStyle style,
    required double fontSize,
    FontWeight? weight,
    double? letterSpacing,
    double? height,
  }) {
    return style.copyWith(
      fontSize: fontSize,
      fontWeight: weight ?? style.fontWeight,
      letterSpacing: letterSpacing ?? style.letterSpacing,
      height: height ?? style.height,
    );
  }
}
