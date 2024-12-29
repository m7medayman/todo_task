import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task/core/common/edit_delete_menue.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/three_dots.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/domain/task_data.dart';
import 'package:task/core/helpers/level_flags.dart';
import 'package:task/core/page_states/page_state_handler.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/rout_manager/rout_manager.dart';
import 'package:task/core/shaper.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/features/task_Details/cubit/task_details_cubit.dart';

class TaskDatailsView extends StatefulWidget {
  const TaskDatailsView({super.key, required this.taskData});
  final TaskData taskData;

  @override
  State<TaskDatailsView> createState() => _TaskDatailsViewState();
}

class _TaskDatailsViewState extends State<TaskDatailsView> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final PageStateHandler pageStateHandler = PageStateHandler();
  late TaskDetailsCubit _cubit;
  @override
  void initState() {
    // TODO: implement initState
    _cubit = TaskDetailsCubit(deleteTaskRepo: getIt());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cubit.close();
    super.dispose();
  }

  GlobalKey _dotKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<TaskDetailsCubit, TaskDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
          pageStateHandler.handlePageState(state.pageState, context);
          if (state.pageState is SuccessPageState) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
                child: Image.asset(
                  "assets/Arrow_Left.png",
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
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
                              top: _getWidgetOffset(_dotKey).dy + 25.h,
                              left: _getWidgetOffset(_dotKey).dx - 65.w,
                              child: EditDeleteMenu(
                                deleteFunction: () {
                                  _cubit.deleteTaks(widget.taskData.id);
                                },
                                editFunction: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.addTask,
                                      arguments: widget.taskData);
                                },
                              )),
                          controller: _tooltipController,
                          child: ThreeDots(
                            key: _dotKey,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/cart.png",
                  height: isPortrait ? 225.h : 150.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h, horizontal: isPortrait ? 22.w : 50.w),
                    child: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.taskData.title,
                          style: FontStyleManager.size24Bold(
                              color: FontColors.black),
                        ),
                        Text(
                          widget.taskData.description,
                          style: FontStyleManager.size14Normal(
                              color: FontColors.grey),
                        ),
                        DateContainer(
                          date: widget.taskData.date,
                        ),
                        StateContainer(
                          state: widget.taskData.status.toS(),
                        ),
                        PriortyContainer(
                          priorty: widget.taskData.flagPoriorty.toS(),
                        ),
                        Center(
                          child: QrImageView(
                            data: widget.taskData.id,
                            size: isPortrait ? 320.r : 160.r,
                            gapless: false,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Offset _getWidgetOffset(GlobalKey key) {
    // Get the RenderBox from the GlobalKey
    RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;

    // Get the position (offset) relative to the screen
    Offset offset = renderBox.localToGlobal(Offset.zero);

    // Print the position
    print("Widget position: $offset");
    return offset;
    // You can use the `offset` to position other widgets (e.g., overlays)
  }
}

class StateContainer extends StatelessWidget {
  const StateContainer({super.key, required this.state});
  final String state;
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
                state,
                style: FontStyleManager.size16Bold(color: FontColors.purple),
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
    required this.priorty,
    super.key,
  });
  final String priorty;

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
                priorty,
                style: FontStyleManager.size16Bold(color: FontColors.purple),
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
  const DateContainer({super.key, required this.date});
  final String date;
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
                        FontStyleManager.size12Normal(color: FontColors.grey),
                  ),
                  Text(
                    date,
                    style:
                        FontStyleManager.size16Normal(color: FontColors.black),
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
