import 'package:flutter/material.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

ThemeData getTheme(context) {
  return ThemeData(
      // colorScheme: ColorManager.getColorScheme(context),
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primaryColor,
        brightness: MediaQuery.platformBrightnessOf(context),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: FontStyleManager().size24Bold(color: FontColors.black)),
      scaffoldBackgroundColor: ColorManager.backgroundColor,
      cardColor: ColorManager.cardColor,
      iconTheme: IconThemeData(color: ColorManager.iconColor),
      buttonTheme: ButtonThemeData(buttonColor: ColorManager.buttonColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  WidgetStatePropertyAll(ColorManager.onPrimaryColor),
              backgroundColor:
                  WidgetStatePropertyAll(ColorManager.primaryColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))))));
}
