import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/helpers/level_flags.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class StatusFlag extends StatelessWidget {
  const StatusFlag({super.key, required this.flag});
  final levelFlag flag;
  @override
  Widget build(BuildContext context) {
    String text = getText();
    Color color = getColor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.flag_outlined,
          color: color,
          size: 20.r,
        ),
        Text(
          text,
          style: FontStyleManager.size14Bold(color: color),
        )
      ],
    );
  }

  String getText() {
    switch (flag) {
      case levelFlag.HEIGH:
        return "High";
      case levelFlag.LOW:
        return "lOW";
      case levelFlag.MEDIUM:
        return "Meduim";
    }
  }

  Color getColor() {
    switch (flag) {
      case levelFlag.HEIGH:
        return FontColors.orange;

      case levelFlag.LOW:
        return FontColors.blue;

      case levelFlag.MEDIUM:
        return FontColors.purple;
    }
  }
}
