import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class password_field extends StatelessWidget {
  const password_field({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Form(
            child: TextField(
                style: FontStyleManager().size14Normal(),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      color: FontColors.grey,
                      Icons.visibility_outlined,
                      size: 24.sp,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                    hintText: "password...",
                    hintStyle: FontStyleManager().size14Normal(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))))));
  }
}
