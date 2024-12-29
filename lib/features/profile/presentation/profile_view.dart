import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/page_states/page_state_handler.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileCubit _cubit;
  @override
  void initState() {
    // TODO: implement initState
    _cubit = ProfileCubit(getIt());
    _cubit.getUerData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cubit.close();
    super.dispose();
  }

  PageStateHandler pageStateHandler = PageStateHandler();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          pageStateHandler.handlePageState(state.pageState, context);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                child: Image.asset(
                  "assets/Arrow_Left.png",
                  width: 12.w,
                  height: 12.h,
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SizedBox(
                height: 30.h,
                child: Row(
                  spacing: 8.w,
                  children: [
                    Text(
                      "profile",
                      style:
                          FontStyleManager.size16Bold(color: FontColors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10.h,
                      children: [
                        ViewContainer(
                          content: state.userProfileData.name,
                          title: 'Name',
                        ),
                        ViewContainer(
                          content: state.userProfileData.phone,
                          title: 'Phone',
                        ),
                        ViewContainer(
                          content:
                              "${state.userProfileData.yearsOfExperience} years",
                          title: 'Experince Years',
                        ),
                        ViewContainer(
                          content: state.userProfileData.location,
                          title: 'Location',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({super.key, required this.content, required this.title});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.greyContainerColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3.h,
          children: [
            Text(
              title,
              style: FontStyleManager.size12Normal(color: FontColors.grey),
            ),
            Text(
              content,
              style: FontStyleManager.size14Bold(color: FontColors.grey),
            )
          ],
        ),
      ),
    );
  }
}
