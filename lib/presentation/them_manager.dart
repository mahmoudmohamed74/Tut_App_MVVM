import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/color_manager.dart';

ThemeData getAppThem() {
  return ThemeData(
    // main colors

    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
  );
}
