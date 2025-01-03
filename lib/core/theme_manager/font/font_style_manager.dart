import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';

class FontStyleManager {
  // Singleton instance

  // Font Sizes (Responsive with ScreenUtil)
  static double get size24 => 22.0.sp;
  static double get size22 => 20.0.sp;
  static double get size16 => 14.0.sp;
  static double get size14 => 12.0.sp;
  static double get size12 => 10.0.sp;

  // Font Weights
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight normal = FontWeight.normal;

  // Colors
  static const Color colorPrimary = FontColors.black;
  static const Color colorSecondary = FontColors.grey;
  static const Color colorAccent = FontColors.grey;

  /// Method to get a custom TextStyle
  static TextStyle custom({
    required double fontSize,
    FontWeight fontWeight = normal,
    Color color = colorPrimary,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  /// Predefined text styles with size in method names (Normal and Bold)
  static TextStyle size24Normal({Color color = colorPrimary}) {
    return custom(fontSize: size24, fontWeight: normal, color: color);
  }

  static TextStyle size24Bold({Color color = colorPrimary}) {
    return custom(fontSize: size24, fontWeight: bold, color: color);
  }

  static TextStyle size22Normal({Color color = colorPrimary}) {
    return custom(fontSize: size22, fontWeight: normal, color: color);
  }

  static TextStyle size22Bold({Color color = colorPrimary}) {
    return custom(fontSize: size22, fontWeight: bold, color: color);
  }

  static TextStyle size16Normal({Color color = colorSecondary}) {
    return custom(fontSize: size16, fontWeight: normal, color: color);
  }

  static TextStyle size16Bold({Color color = colorSecondary}) {
    return custom(fontSize: size16, fontWeight: bold, color: color);
  }

  static TextStyle size14Normal({Color color = colorAccent}) {
    return custom(fontSize: size14, fontWeight: normal, color: color);
  }

  static TextStyle size14Bold({Color color = colorAccent}) {
    return custom(fontSize: size14, fontWeight: bold, color: color);
  }

  static TextStyle size12Normal({Color color = colorAccent}) {
    return custom(fontSize: size12, fontWeight: normal, color: color);
  }

  static TextStyle size12Bold({Color color = colorAccent}) {
    return custom(fontSize: size12, fontWeight: bold, color: color);
  }
}
