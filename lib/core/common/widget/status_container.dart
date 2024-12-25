import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.status});
  final ItemStatus status;
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ItemStatus.WAITING:
        return const _ManiStatusContainer(
            text: "Waiting",
            containerColor: ItemStatusColor.waiting,
            textColor: FontColors.orange);
      case ItemStatus.INPROGRESS:
        return const _ManiStatusContainer(
            text: "Inprogress",
            containerColor: ItemStatusColor.inprogress,
            textColor: FontColors.purple);
      case ItemStatus.FINISHED:
        return const _ManiStatusContainer(
            text: "Finished",
            containerColor: ItemStatusColor.finished,
            textColor: FontColors.blue);
    }
  }
}

class _ManiStatusContainer extends StatelessWidget {
  const _ManiStatusContainer(
      {super.key,
      required this.text,
      required this.containerColor,
      required this.textColor});
  final String text;
  final Color containerColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.w),
        child: Text(
          text,
          style: FontStyleManager().size12Bold(color: textColor),
        ),
      ),
    );
  }
}

enum ItemStatus {
  WAITING,
  INPROGRESS,
  FINISHED,
}

class ItemStatusColor {
  static const Color waiting = Color(0xffFFE4F2);
  static const Color inprogress = Color(0xffF0ECFF);
  static const Color finished = Color(0xffE3F2FF);
}
