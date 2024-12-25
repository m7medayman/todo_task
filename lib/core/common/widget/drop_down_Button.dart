import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton(
      {super.key, required this.formKey, required this.controller});
  final GlobalKey formKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: DropdownButtonFormField(
            icon: Image.asset(
              "assets/Arrow_Down.png",
              width: 24.w,
              height: 24.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                hintText: "Chose ",
                hintStyle: FontStyleManager().size14Normal(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            items: [
              DropdownMenuItem(
                  value: 'fresh',
                  child: Text(
                    'Fresh',
                    style: FontStyleManager().size14Normal(),
                  )),
              DropdownMenuItem(
                  value: 'junior',
                  child:
                      Text('Junior', style: FontStyleManager().size14Normal())),
              DropdownMenuItem(
                  value: 'midLevel',
                  child: Text('MidLevel',
                      style: FontStyleManager().size14Normal())),
              DropdownMenuItem(
                  value: 'senior',
                  child:
                      Text('Senior', style: FontStyleManager().size14Normal())),
            ],
            onChanged: (value) {
              controller.text = value.toString();
            }));
  }
}
