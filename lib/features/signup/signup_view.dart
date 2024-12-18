import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/common/widget/general_input_field.dart';
import 'package:task/core/common/widget/password_input_field.dart';
import 'package:task/core/common/widget/phone_input_field.dart';
import 'package:task/core/theme_manager/font/font_color.dart';
import 'package:task/core/theme_manager/font/font_style_manager.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      scale: 0.2,
                      fit: BoxFit.fill,
                      "assets/back_ground.png",
                      width: 375.w,
                      height: 350.h,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: 326.w,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 300.h,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey
                                  .withOpacity(0.1), // Semi-transparent
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  child: Text(
                                    "Signup",
                                    style: FontStyleManager().size24Bold(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GeneralInputField(
                                    textEditingController:
                                        TextEditingController(),
                                    formKey: GlobalKey(),
                                    hintText: "Name"),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Phone_input_field(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GeneralInputField(
                                    textEditingController:
                                        TextEditingController(),
                                    formKey: GlobalKey(),
                                    hintText: "Years of experience..."),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GeneralInputField(
                                    textEditingController:
                                        TextEditingController(),
                                    formKey: GlobalKey(),
                                    hintText: "Choose experience Level"),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GeneralInputField(
                                    textEditingController:
                                        TextEditingController(),
                                    formKey: GlobalKey(),
                                    hintText: "Address..."),
                                SizedBox(
                                  height: 20.h,
                                ),
                                password_field(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize: WidgetStatePropertyAll(
                                            Size(1, 50.h))),
                                    onPressed: () {},
                                    child: Text(
                                      "Sign up",
                                      style: FontStyleManager().size16Bold(
                                          color: FontColors.onButton),
                                    )),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Already have any account?",
                                        style:
                                            FontStyleManager().size14Normal(),
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Sign in",
                                            style: FontStyleManager()
                                                .size14Normal(
                                                    color: FontColors.purple)
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
