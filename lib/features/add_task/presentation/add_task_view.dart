import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/common/widget/drop_down_Button.dart';
import 'package:task/core/common/widget/drop_down_priority_flag.dart';
import 'package:task/core/common/widget/general_input_field.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/status_drop_down_button.dart';
import 'package:task/core/common/widget/status_flag.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/helpers/level_flags.dart';
import 'package:task/core/page_states/page_state_handler.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';
import 'package:task/features/add_task/data/add_edit_task_repo.dart';
import 'package:task/features/add_task/presentation/cubit/add_edit_cubit.dart';
import 'package:task/core/domain/task_data.dart';
import 'package:task/features/login/presentation/login_view.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, this.taskData});
  final TaskData? taskData;
  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  late AddEditCubit _cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = AddEditCubit(getIt<AddEditTaskRepo>(), getIt<SecureStorage>());
    if (widget.taskData != null) {
      titleController.text = widget.taskData!.title;
      descriptionController.text = widget.taskData!.description;
      priorityController.text = flagToString(widget.taskData!.flagPoriorty);
      dateController.text = widget.taskData!.date;
      statusController.text = widget.taskData!.status.toS();
      _cubit.changeEditState(true, widget.taskData!.id);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    descriptionController.dispose();
    dateController.dispose();
    priorityController.dispose();
    titleController.dispose();
    super.dispose();
  }

  String flagToString(levelFlag flag) {
    print(flag.toS());
    switch (flag) {
      case levelFlag.HEIGH:
        return "high";
      case levelFlag.LOW:
        return "low";
      case levelFlag.MEDIUM:
        return "medium";
    }
  }

  Future<void> _showSourceDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Visibility(
                  visible: Platform.isAndroid,
                  child: ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Camera'),
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    _getImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        // User canceled the picker
      }
    });
  }

  final TextEditingController statusController = TextEditingController();
  final GlobalKey<FormState> statusformKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> titleformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> descformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyDropDown = GlobalKey<FormState>();
  final TextEditingController priorityController = TextEditingController();
  final GlobalKey<FormState> formKeyDate = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final PageStateHandler pageStateHandler = PageStateHandler();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<AddEditCubit, AddEditState>(
        listener: (context, state) {
          pageStateHandler.handlePageState(state.pageState, context);
          if (state.pageState is SuccessPageState) {
            Navigator.of(context).pop();
          }
          // TODO: implement listener
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
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SizedBox(
                height: 50.h,
                child: Row(
                  spacing: 8.w,
                  children: [
                    Text(
                      "add and edit tasks",
                      style:
                          FontStyleManager.size16Bold(color: FontColors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<AddEditCubit, AddEditState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 331.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 20.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                              onTap: _showSourceDialog,
                              child: ImageAddContainer()),
                          InputField(
                            title: 'Task title',
                            textEditingController: titleController,
                            formKey: titleformKey,
                            hintText: 'Enter title here ....',
                          ),
                          InputField(
                            textEditingController: descriptionController,
                            formKey: descformKey,
                            title: 'Task Description',
                            hintText: 'Enter description here ....',
                            maxLines: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8.h,
                            children: [
                              Text(
                                "Priority",
                                style: FontStyleManager.size12Normal(
                                    color: FontColors.grey),
                              ),
                              MyFlagPriorityDropDownButton(
                                  formKey: formKeyDropDown,
                                  controller: priorityController)
                            ],
                          ),
                          Visibility(
                            visible: state.isEdit,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8.h,
                              children: [
                                Text(
                                  "Status",
                                  style: FontStyleManager.size12Normal(
                                      color: FontColors.grey),
                                ),
                                StatusDropDownButton(
                                    formKey: statusformKey,
                                    controller: statusController)
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8.h,
                            children: [
                              Text(
                                "Due Date",
                                style: FontStyleManager.size12Normal(
                                    color: FontColors.grey),
                              ),
                              GeneralInputField(
                                  textEditingController: dateController,
                                  formKey: formKeyDate,
                                  readOnly: true,
                                  onTap: () {
                                    if (state.isEdit) {
                                      return;
                                    }
                                    showDatePicker(
                                            context: context,
                                            firstDate: DateTime(2000),
                                            initialDate: DateTime.now(),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      if (value != null) {
                                        String year = value.year.toString();
                                        String month = value.month.toString();
                                        String day = value.day.toString();
                                        dateController.text =
                                            "$year-$month-$day";
                                      }
                                    });
                                  },
                                  iconData: Padding(
                                    padding: EdgeInsets.all(6.0.r),
                                    child: Image.asset(
                                      "assets/calendar.png",
                                      width: 5.w,
                                      height: 16.h,
                                    ),
                                  ),
                                  hintText: "choose due date..."),
                            ],
                          ),
                          MyButton(
                              lable: state.isEdit ? "save task" : "Add task ",
                              onPressed: () {
                                if (formKeyDate.currentState!.validate() &&
                                    formKeyDropDown.currentState!.validate() &&
                                    titleformKey.currentState!.validate() &&
                                    descformKey.currentState!.validate()) {
                                  if (state.isEdit) {
                                    if (!statusformKey.currentState!
                                        .validate()) {
                                      return;
                                    }
                                  }
                                  _cubit.submitButton(
                                      titleController.text,
                                      descriptionController.text,
                                      priorityController.text,
                                      state.isEdit
                                          ? statusController.text
                                          : dateController.text);
                                }
                              })
                        ],
                      ),
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

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    this.maxLines = 1,
    required this.hintText,
    required this.textEditingController,
    required this.formKey,
  });
  final TextEditingController textEditingController;
  final GlobalKey formKey;
  final String title;
  final int maxLines;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontStyleManager.size12Normal(),
        ),
        GeneralInputField(
            maxLines: maxLines,
            textEditingController: textEditingController,
            formKey: formKey,
            hintText: hintText)
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
                  style: FontStyleManager.size16Bold(color: FontColors.purple),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
