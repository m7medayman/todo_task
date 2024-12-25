import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/common/widget/three_dots.dart';
import 'package:task/core/shaper.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class TaskDatailsView extends StatefulWidget {
  const TaskDatailsView({super.key});

  @override
  State<TaskDatailsView> createState() => _TaskDatailsViewState();
}

class _TaskDatailsViewState extends State<TaskDatailsView> {
  final OverlayPortalController _tooltipController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () {
                    _tooltipController.toggle();
                  },
                  child: OverlayPortal(
                      overlayChildBuilder: (context) => Positioned(
                          top: 50.h, right: -2, child: EditDeleteMenu()),
                      controller: _tooltipController,
                      child: ThreeDots()),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/cart.png",
              height: 225.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
                child: Column(
                  spacing: 12.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Grocery Shopping App",
                      style: FontStyleManager()
                          .size24Bold(color: FontColors.black),
                    ),
                    Text(
                      ''' This application is designed for super shops. By using 
        this application they can enlist all their products in one 
        place and can deliver. Customers will get a one-stop 
        solution for their daily shopping''',
                      style: FontStyleManager()
                          .size14Normal(color: FontColors.grey),
                    ),
                    DateContainer(),
                    StateContainer(),
                    PriortyContainer()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class StateContainer extends StatelessWidget {
  const StateContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.greyContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
          child: Row(
            spacing: 2.w,
            children: [
              Text(
                "Inprogress",
                style: FontStyleManager().size16Bold(color: FontColors.purple),
              ),
              Spacer(),
              Image.asset(
                "assets/Arrow_Down.png",
                width: 24.w,
                height: 24.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PriortyContainer extends StatelessWidget {
  const PriortyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.greyContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
          child: Row(
            spacing: 2.w,
            children: [
              Icon(
                size: 28.r,
                Icons.flag_outlined,
                color: FontColors.purple,
              ),
              Text(
                "Inprogress",
                style: FontStyleManager().size16Bold(color: FontColors.purple),
              ),
              Spacer(),
              Image.asset(
                "assets/Arrow_Down.png",
                width: 24.w,
                height: 24.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  const DateContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.greyContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "End Date",
                    style:
                        FontStyleManager().size12Normal(color: FontColors.grey),
                  ),
                  Text(
                    "30 June, 2022",
                    style: FontStyleManager()
                        .size16Normal(color: FontColors.black),
                  )
                ],
              ),
              Spacer(),
              Image.asset(
                "assets/calendar.png",
                width: 24.w,
                height: 24.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditDeleteMenu extends StatelessWidget {
  const EditDeleteMenu({
    super.key,
  });

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
              Text(
                "Edit",
                style: FontStyleManager().size12Bold(),
              ),
              const Divider(),
              Text(
                "Delete",
                style: FontStyleManager().size12Bold(color: FontColors.orange),
              ),
            ],
          ),
        )
      ],
    );
  }
}
