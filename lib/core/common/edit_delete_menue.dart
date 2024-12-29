import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class EditDeleteMenu extends StatelessWidget {
  const EditDeleteMenu(
      {super.key, required this.deleteFunction, required this.editFunction});
  final Function() deleteFunction;
  final Function() editFunction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 70.w,
          height: 85.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 0.1, // How much the shadow spreads
                blurRadius: 30, // The blur radius of the shadow
                offset: Offset(0, 4), // Offset of the shadow
              ),
            ],
          ),
        ),
        Container(
          width: 98.w,
          height: 98.h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Vector.png"), fit: BoxFit.fill)),
        ),
        Container(
          width: 50.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: editFunction,
                child: Text(
                  "Edit",
                  style: FontStyleManager.size14Bold(),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: deleteFunction,
                child: Text(
                  "Delete",
                  style: FontStyleManager.size14Bold(color: FontColors.orange),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
