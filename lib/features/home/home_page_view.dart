import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/common/widget/custom_radio_container.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/status_flag.dart';
import 'package:task/core/common/widget/three_dots.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10.h,
        children: [
          SizedBox(
            width: 50.h,
            height: 50.h,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: ColorManager.greyContainerColor,
              onPressed: () {},
              child: Icon(
                Icons.qr_code,
                size: 24.r,
                color: ColorManager.primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 64.h,
            height: 64.h,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: ColorManager.primaryColor,
              onPressed: () {},
              child: Icon(
                Icons.add,
                size: 32.r,
                color: ColorManager.backgroundColor,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 56.h,
        title: Row(
          children: [
            Text(
              "Logo",
              style: FontStyleManager().size22Bold(),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_outline_rounded,
              size: 24.r,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.login_outlined,
              color: FontColors.purple,
              size: 24.r,
            ),
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 331.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                "My Tasks",
                style: FontStyleManager().size16Bold(),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Row(
                  spacing: 4.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRadioContainer(isSelected: true, text: "All"),
                    CustomRadioContainer(isSelected: false, text: "inprogress"),
                    CustomRadioContainer(isSelected: false, text: "Wating"),
                    CustomRadioContainer(isSelected: false, text: "Finished"),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              ViewItem(),
              ViewItem(),
              ViewItem(),
              ViewItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewItem extends StatelessWidget {
  const ViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 115.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/supermarket_cart.png',
                    width: 70.w,
                    height: 70.h,
                  ),
                  SizedBox(
                    width: 230.w,
                    height: 90.h,
                    child: Column(
                      spacing: 4.h,
                      children: [
                        SizedBox(
                          height: 35.h,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grocery Shopping...",
                                style: FontStyleManager()
                                    .size16Bold(color: FontColors.black),
                              ),
                              StatusContainer(status: ItemStatus.INPROGRESS)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                          child: Text(
                            "this application is designed for shis application is designed for s",
                            style: FontStyleManager()
                                .size14Normal(color: FontColors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                          child: Row(
                            children: [
                              const StatusFlag(flag: levelFlag.MEDIUM),
                              const Spacer(),
                              Text(
                                "30/12/2022",
                                style: FontStyleManager()
                                    .size14Normal(color: FontColors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ThreeDots(),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
