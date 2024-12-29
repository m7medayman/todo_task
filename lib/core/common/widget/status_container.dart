import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.status, required this.style});
  final ItemStatus status;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ItemStatus.WAITING:
        return _ManiStatusContainer(
          style: style,
          text: "Waiting",
          containerColor: ItemStatusColor.waiting,
        );
      case ItemStatus.INPROGRESS:
        return _ManiStatusContainer(
          style: style,
          text: "Inprogress",
          containerColor: ItemStatusColor.inprogress,
        );
      case ItemStatus.FINISHED:
        return _ManiStatusContainer(
          style: style,
          text: "Finished",
          containerColor: ItemStatusColor.finished,
        );
    }
  }
}

class _ManiStatusContainer extends StatelessWidget {
  const _ManiStatusContainer({
    super.key,
    required this.text,
    required this.containerColor,
    required this.style,
  });
  final String text;
  final Color containerColor;

  final TextStyle style;

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
          style: style,
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

extension ToString on ItemStatus {
  String toS() {
    switch (this) {
      case ItemStatus.FINISHED:
        return "finished";
      case ItemStatus.INPROGRESS:
        return "inprogress";
      case ItemStatus.WAITING:
        return "waiting";
    }
  }
}

class ItemStatusColor {
  static const Color waiting = Color(0xffFFE4F2);
  static const Color inprogress = Color(0xffF0ECFF);
  static const Color finished = Color(0xffE3F2FF);
}
