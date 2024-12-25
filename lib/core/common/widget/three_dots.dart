import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThreeDots extends StatelessWidget {
  const ThreeDots({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 10.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 3.h,
        children: [
          CircleAvatar(
            radius: 2.2.r,
            backgroundColor: Colors.black,
          ),
          CircleAvatar(
            radius: 2.2.r,
            backgroundColor: Colors.black,
          ),
          CircleAvatar(
            radius: 2.2.r,
            backgroundColor: Colors.black,
          )
        ],
      ),
    );
  }
}
