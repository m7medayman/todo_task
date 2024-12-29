import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class CustomRadioContainer extends StatelessWidget {
  const CustomRadioContainer({
    super.key,
    required this.isSelected,
    required this.text,
  });
  final bool isSelected;
  final String text;
  // final bool isPortorit;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: isPortorit ? 36.h : 20.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected
              ? ColorManager.primaryColor
              : ColorManager.greyContainerColor),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          child: Text(text,
              overflow: TextOverflow.ellipsis,
              style: isSelected
                  ? FontStyleManager.size16Bold(color: FontColors.white)
                  : FontStyleManager.size16Normal(color: FontColors.grey)),
        ),
      ),
    );
  }
}
