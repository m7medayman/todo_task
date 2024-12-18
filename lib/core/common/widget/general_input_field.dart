import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class GeneralInputField extends StatelessWidget {
  const GeneralInputField({
    super.key,
    required this.textEditingController,
    required this.formKey,
    required this.hintText,
    this.iconData,
  });
  final TextEditingController textEditingController;
  final GlobalKey formKey;
  final String hintText;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Form(
            key: formKey,
            child: TextField(
                controller: textEditingController,
                style: FontStyleManager().size14Normal(),
                decoration: InputDecoration(
                    icon: iconData == null
                        ? null
                        : Icon(
                            iconData,
                            size: 20.sp,
                            color: FontColors.grey,
                          ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                    hintText: hintText,
                    hintStyle: FontStyleManager().size14Normal(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))))));
  }
}
