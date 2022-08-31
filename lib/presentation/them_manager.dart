import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/color_manager.dart';
import 'package:flutter_advanced/presentation/values_manager.dart';

ThemeData getAppThem() {
  return ThemeData(
      // main colors

      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,

      // card view

      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ));
}
