import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/color_manager.dart';
import 'package:flutter_advanced/presentation/font_manager.dart';
import 'package:flutter_advanced/presentation/styles_manager.dart';
import 'package:flutter_advanced/presentation/values_manager.dart';

ThemeData getAppThem() {
  return ThemeData(
    // main colors

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    // card view

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar them
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),
  );
}
