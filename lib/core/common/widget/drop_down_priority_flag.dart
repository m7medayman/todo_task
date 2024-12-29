import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';

import '../../theme_manager/font/font_style_manager.dart';

class MyFlagPriorityDropDownButton extends StatelessWidget {
  const MyFlagPriorityDropDownButton(
      {super.key, required this.formKey, required this.controller});
  final GlobalKey formKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: DropdownButtonFormField(
            style: FontStyleManager.size16Bold(color: FontColors.purple),
            icon: Image.asset(
              "assets/Arrow_Down.png",
              width: 24.w,
              height: 24.h,
            ),
            value: controller.text.isEmpty ? null : controller.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
            decoration: InputDecoration(
                focusedErrorBorder: null,
                focusedBorder: null,
                enabledBorder: null,
                disabledBorder: null,
                filled: true,
                fillColor: ColorManager.lightGreyColor,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                hintText: "Chose ",
                hintStyle: FontStyleManager.size16Bold(),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10))),
            items: [
              DropdownMenuItem(
                  value: 'medium',
                  child: Row(
                    spacing: 3.w,
                    children: [
                      const Icon(
                        Icons.flag_outlined,
                        color: FontColors.purple,
                      ),
                      Text('Meduim priority',
                          style: FontStyleManager.size16Bold(
                              color: FontColors.purple)),
                    ],
                  )),
              DropdownMenuItem(
                  value: 'high',
                  child: Row(
                    spacing: 3.w,
                    children: [
                      const Icon(
                        Icons.flag_outlined,
                        color: FontColors.orange,
                      ),
                      Text('high priority',
                          style: FontStyleManager.size16Bold(
                              color: FontColors.orange)),
                    ],
                  )),
              DropdownMenuItem(
                  value: 'low',
                  child: Row(
                    spacing: 3.w,
                    children: [
                      const Icon(
                        Icons.flag_outlined,
                        color: FontColors.blue,
                      ),
                      Text('Low priority',
                          style: FontStyleManager.size16Bold(
                              color: FontColors.blue)),
                    ],
                  )),
            ],
            onChanged: (value) {
              controller.text = value.toString();
            }));
  }
}
