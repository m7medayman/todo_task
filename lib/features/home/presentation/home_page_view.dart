import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task/core/common/edit_delete_menue.dart';
import 'package:task/core/common/widget/custom_radio_container.dart';
import 'package:task/core/common/widget/qr_page.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/status_flag.dart';
import 'package:task/core/common/widget/three_dots.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/helpers/level_flags.dart';
import 'package:task/core/page_states/page_state_handler.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/rout_manager/rout_manager.dart';
import 'package:task/core/state_renderer/pop_state_dialog_widget.dart';
import 'package:task/core/theme_manager/color_manager.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/features/home/presentation/cubit/home_cubit.dart';
import 'package:task/features/task_Details/task_datails_view.dart';

class HomePageView extends StatefulWidget {
  HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  PageStateHandler pageStateHandler = PageStateHandler();
  final ScrollController _scrollController = ScrollController();
  late HomeCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = getIt<HomeCubit>();
    cubit.updateHomeData();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          pageStateHandler.handlePageState(state.pageState, context);
          if (state.pageState is QRTaskPageState) {
            var s = state.pageState as QRTaskPageState;
            Navigator.of(context)
                .pushNamed(Routes.taskDetail, arguments: s.data)
                .then((value) {
              context.read<HomeCubit>().reset();
              context.read<HomeCubit>().updateHomeData();
            });
          }
          if (state.pageState is LoadingHomePageState) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }

          _fetchMoreItems() {
            HomeState state = context.read<HomeCubit>().state;
            if (state.pageState is! LoadingHomePageState) {
              context.read<HomeCubit>().updateHomeData();
            }
          }

          void _scrollListener() {
            if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent &&
                state.pageState is! LoadingHomePageState) {
              _fetchMoreItems();
            }
          }

          _scrollController.addListener(_scrollListener);

          // pageStateHandler.handlePageState(state.pageState, context);
          // TODO: implement listener
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: isPortrait ? 10.h : 2.h,
                children: [
                  Visibility(
                    visible: Platform.isAndroid,
                    child: SizedBox(
                      width: isPortrait ? 50.w : 30.w,
                      height: isPortrait ? 50.h : 30.h,
                      child: FloatingActionButton(
                        heroTag: 'uniqueTag1',
                        shape: const CircleBorder(),
                        backgroundColor: ColorManager.greyContainerColor,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.qrPage)
                              .then((scannedValue) {
                            if (scannedValue != null) {
                              print('Scanned QR Code: $scannedValue');
                              cubit.qrTaske(scannedValue.toString());
                            } else {
                              print('No QR Code Scanned');
                            }
                          });
                        },
                        child: Icon(
                          Icons.qr_code,
                          size: 24.r,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isPortrait ? 64.w : 35.w,
                    height: isPortrait ? 64.h : 35.h,
                    child: FloatingActionButton(
                      heroTag: 'uniqueTag2',
                      shape: const CircleBorder(),
                      backgroundColor: ColorManager.primaryColor,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Routes.addTask)
                            .then((value) {
                          context.read<HomeCubit>().reset();
                          context.read<HomeCubit>().updateHomeData();
                        });
                      },
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
                toolbarHeight: isPortrait ? 56.h : 35.h,
                title: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isPortrait ? 6.w : 53.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Logo",
                        style: FontStyleManager.size22Bold(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.profile);
                    },
                    icon: Icon(
                      Icons.person_outline_rounded,
                      size: 24.r,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.logOut();
                      Navigator.of(context).pushReplacementNamed(Routes.login);
                    },
                    icon: Icon(
                      Icons.login_outlined,
                      color: FontColors.purple,
                      size: 24.r,
                    ),
                  )
                ],
              ),
              body: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  // width: 331.w,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: isPortrait ? 15.h : 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isPortrait ? 20.w : 70.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: isPortrait ? 15.h : 5.h,
                            children: [
                              Text(
                                "My Tasks",
                                style: FontStyleManager.size16Bold(),
                              ),
                              Center(
                                child: Row(
                                  spacing: 4.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<HomeCubit>()
                                            .setAllFilter();
                                      },
                                      child: CustomRadioContainer(
                                          isSelected: state.all, text: "All"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<HomeCubit>()
                                            .setInProgressFilter();
                                      },
                                      child: CustomRadioContainer(
                                          isSelected: state.inProgress,
                                          text: "inprogress"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<HomeCubit>()
                                            .setWaitingFilter();
                                      },
                                      child: CustomRadioContainer(
                                          isSelected: state.waiting,
                                          text: "Waiing"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<HomeCubit>()
                                            .setFinishedFilter();
                                      },
                                      child: CustomRadioContainer(
                                          isSelected: state.finished,
                                          text: "Finished"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: isPortrait ? 15.h : 5.h,
                        ),
                        Container(
                          height: isPortrait ? 620.h : 200.h,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                state.filterdTask.length + (_isLoading ? 1 : 0),
                            itemBuilder: (BuildContext context, int index) {
                              return (index < state.filterdTask.length)
                                  ? ViewItem(
                                      isportrait: isPortrait,
                                      onDelete: () {
                                        context.read<HomeCubit>().deleteTaks(
                                            state.filterdTask[index].id);
                                      },
                                      onEdit: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.addTask,
                                                arguments:
                                                    state.filterdTask[index])
                                            .then((value) {
                                          context.read<HomeCubit>().reset();
                                          context
                                              .read<HomeCubit>()
                                              .updateHomeData();
                                        });
                                      },
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.taskDetail,
                                                arguments:
                                                    state.filterdTask[index])
                                            .then((value) {
                                          context.read<HomeCubit>().reset();
                                          context
                                              .read<HomeCubit>()
                                              .updateHomeData();
                                        });
                                      },
                                      title: state.filterdTask[index].title,
                                      description:
                                          state.filterdTask[index].description,
                                      date: state.filterdTask[index].date,
                                      flagPoriorty:
                                          state.filterdTask[index].flagPoriorty,
                                      status: state.filterdTask[index].status,
                                    )
                                  : Container(
                                      height: 50.h,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                              ;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ViewItem extends StatefulWidget {
  const ViewItem(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.flagPoriorty,
      required this.status,
      required this.onTap,
      required this.onEdit,
      required this.onDelete,
      required this.isportrait});
  final String title;
  final String description;
  final String date;
  final levelFlag flagPoriorty;
  final ItemStatus status;
  final void Function() onTap;
  final void Function() onEdit;
  final void Function() onDelete;
  final bool isportrait;
  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  GlobalKey myKey = GlobalKey();
  bool _showPopEditDelete = false;
  late TextStyle style;
  TextStyle getStyle() {
    switch (widget.status) {
      case ItemStatus.WAITING:
        return FontStyleManager.size14Bold(color: FontColors.orange);
      case ItemStatus.FINISHED:
        return FontStyleManager.size14Bold(color: FontColors.blue);
      case ItemStatus.INPROGRESS:
        return FontStyleManager.size14Bold(color: FontColors.purple);
    }
  }

  @override
  Widget build(BuildContext context) {
    style = getStyle();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.isportrait ? 20.w : 70.w,
          vertical: widget.isportrait ? 12.h : 10.h),
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 115.h,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: widget.onTap,
                        child: Image.asset(
                          'assets/supermarket_cart.png',
                          width: 70.w,
                          height: 70.h,
                        ),
                      ),
                      InkWell(
                        onTap: widget.onTap,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 90.h,
                          ),
                          child: SizedBox(
                            width: 230.w,
                            child: Column(
                              spacing: 4.h,
                              children: [
                                SizedBox(
                                  // height: 35.h,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Text(
                                          widget.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyleManager.size16Bold(
                                              color: FontColors.black),
                                        ),
                                      ),
                                      StatusContainer(
                                        status: widget.status,
                                        style: style,
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      // height: 24.h,
                                      width: 210.w,
                                      child: Text(
                                        widget.description,
                                        style: FontStyleManager.size14Normal(
                                            color: FontColors.grey),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    StatusFlag(flag: widget.flagPoriorty),
                                    const Spacer(),
                                    Text(
                                      widget.date,
                                      style: FontStyleManager.size14Normal(
                                          color: FontColors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 10.w,
                            // height: 40.h,
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () {
                  setState(() {
                    _showPopEditDelete = !_showPopEditDelete;
                  });
                },
                child: ThreeDots(
                  key: myKey,
                )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(20.w, 25.h),
              child: Visibility(
                  visible: _showPopEditDelete,
                  child: EditDeleteMenu(deleteFunction: () {
                    setState(() {
                      _showPopEditDelete = false;
                    });
                    widget.onDelete();
                  }, editFunction: () {
                    setState(() {
                      _showPopEditDelete = false;
                    });
                    widget.onEdit();
                  })),
            ),
          ),
        ],
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
