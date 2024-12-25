import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: SizedBox(
            height: 50.h,
            child: Row(
              spacing: 8.w,
              children: [
                Image.asset(
                  "assets/Arrow_Left.png",
                  width: 24.w,
                  height: 24.h,
                ),
                Text(
                  "Add new task",
                  style: FontStyleManager().size16Bold(color: FontColors.black),
                )
              ],
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 331.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: SingleChildScrollView(
              child: Column(
                spacing: 15.h,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageAddContainer(),
                  InputField(
                    title: 'Task title',
                    hintText: 'Enter title here ....',
                  ),
                  InputField(
                    title: 'Task Description',
                    hintText: 'Enter description here ....',
                    minLines: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    this.minLines = 1,
    required this.hintText,
  });
  final String title;
  final int minLines;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontStyleManager().size12Normal(),
        ),
        Form(
            child: TextField(
          maxLines: minLines,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: hintText,
              hintStyle:
                  FontStyleManager().size14Normal(color: FontColors.grey)),
        ))
      ],
    );
  }
}

class ImageAddContainer extends StatelessWidget {
  const ImageAddContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [5, 5],
      color: FontColors.purple,
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      strokeWidth: 2,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 56.h),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent, // Remove default border
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5.w,
              children: [
                Image.asset(
                  "assets/add_image.png",
                  width: 24.w,
                  height: 24.h,
                ),
                Text(
                  "Add Img",
                  style:
                      FontStyleManager().size16Bold(color: FontColors.purple),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
