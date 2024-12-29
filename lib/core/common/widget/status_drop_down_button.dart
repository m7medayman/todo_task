import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class StatusDropDownButton extends StatelessWidget {
  const StatusDropDownButton({
    super.key,
    required this.formKey,
    required this.controller,
  });

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
            return 'Please select a status';
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
          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
          hintText: "Choose status",
          hintStyle: FontStyleManager.size16Bold(),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: [
          DropdownMenuItem(
            value: 'finished',
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: FontColors.purple,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Finished',
                  style: FontStyleManager.size16Bold(color: FontColors.purple),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'waiting',
            child: Row(
              children: [
                const Icon(
                  Icons.hourglass_empty,
                  color: FontColors.orange,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Waiting',
                  style: FontStyleManager.size16Bold(color: FontColors.orange),
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'inprogress',
            child: Row(
              children: [
                const Icon(
                  Icons.sync,
                  color: FontColors.blue,
                ),
                SizedBox(width: 8.w),
                Text(
                  'In Progress',
                  style: FontStyleManager.size16Bold(color: FontColors.blue),
                ),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          controller.text = value.toString();
        },
      ),
    );
  }
}